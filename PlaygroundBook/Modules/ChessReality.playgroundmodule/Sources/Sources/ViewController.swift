// ViewController.swift
// ChessReality
// Created by Anav Mehta 3/5/2020
// Copyright (c) 2020 Anav Mehta. All rights reserved

import UIKit
import ARKit
import RealityKit
import MultipeerConnectivity
import AVFoundation
//import ChessEngine
import PlaygroundSupport
import SwiftChess


public class ViewController: UIViewController, GameDelegate, //{
PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {


    var audioPlayer: AVAudioPlayer!
    public var soundEnabled: Bool = true
    public var animationEnabled: Bool = true
    let audioFilePathWrong = Bundle.main.path(forResource:"wrong", ofType: "wav")
    let audioFilePathSafe = Bundle.main.path(forResource:"mallert 008", ofType: "mp3")
    let audioFilePathWon = Bundle.main.path(forResource:"crowd", ofType: "mp3")
    var bestMoveNext: String! = ""
    var boardType: Int = 0
    var finishedAnalyzing: Bool = true {
        didSet {
            if(finishedAnalyzing == true) {
                CFRunLoopStop(runLoop)
            }
        }
    }
    var computerPlays: Bool = false
    var numMoves:Int = 0
    /// The app's root view.
    public var arView: ARView!
    var banner:UILabel! = UILabel()
    var recordBanner:UILabel! = UILabel()
    var fenBanner:UILabel! = UILabel()
    var sessionInfoLabel: UILabel! = UILabel()
    let items = ["Single Device", "Play With Computer", "Play With Opponent"]
    var customSC: UISegmentedControl!
    var peerSessionIDs = [MCPeerID: String]()
    var hintButton: UIButton! = UIButton()
    public let hintImg = UIImage(named: "iconfinder_bulb_1511312")
    
    var gameFen: String = "position fen rnbqkbnr/pppp1ppp/8/4p3/3P4/8/PPP1PPPP/RNBQKBNR w KQkq -"
    var castling: String = "-"
    var curColor: String = "w" {
        didSet {
            if(curColor == "w") {banner.text = "You are white"}
            else {banner.text = "You are black"}
        }
    }
    var allowComputerPlay: Bool = false
    var allowMultipeerPlay: Bool = false
    var game: Entity!
    var computer: Game!
    var gameAnchored: Bool = false
    var modelTapped: Bool = false
    
    var mapProvider: MCPeerID?
    var planeAnchor: ARAnchor!
    
    public let coachingOverlay: ARCoachingOverlayView! = ARCoachingOverlayView()
    
    var selectedPiece: Entity! = nil
    var selectedAnchor: AnchorEntity! = nil
    var selectedBoard: Bool = false
    
    var multipeerSession: MultipeerSession!
    var sessionIDObservation: NSKeyValueObservation?
    
    var overlayEntities: [[ModelEntity]] = Array<[ModelEntity]>(repeating: Array<ModelEntity>(repeating: ModelEntity(), count: 8), count:8)
    var occupied: [[Bool]] = Array<[Bool]>(repeating: Array<Bool>(repeating: false, count:8), count: 8)
    var position: [[String]] = Array(repeating: Array(repeating: " ", count: 8), count: 8)
    
    var moves: [(Int, Int)] = []
    var startPos: SIMD3<Float>!
    var startPosXY: (Int, Int)!
    var endPosXY: (Int, Int)!
    let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default)
    var peerToPlay: Bool = false
    
    let charArray = ["a","b","c","d","e","f","g","h"]
    let numArray = ["1","2","3","4","5","6","7","8"]
    
    var planeAnchorAdded: Bool = false {
        didSet {
            if(planeAnchorAdded == true) {
                self.send(.string("wait"))
                CFRunLoopStop(runLoop)
            }
        }
    }
    var connectedWithPeer: Bool = false
    var placedBoard: Bool = false
    var owner: Bool = false
    var recordString: String = ""
    var idLabel: UILabel! = UILabel()
    var peerIdLabel: UILabel! = UILabel()
    
    public func sound(enabled: Bool) {
        soundEnabled = enabled
    }
    public func animation(enabled: Bool) {
        animationEnabled = enabled
    }
    
    func playSound(sound: Int) {
        var audioFilePath: String!
        if(!soundEnabled) {return}
        if(sound == 0) {
            audioFilePath = audioFilePathWrong
        } else if(sound == 1) {
            audioFilePath = audioFilePathSafe
        } else if(sound == 2) {
            audioFilePath = audioFilePathWon
        }
        if audioFilePath != nil {
            
            let audioFileUrl = NSURL.fileURL(withPath: audioFilePath!)
            do {
                audioPlayer = try AVAudioPlayer.init(contentsOf: audioFileUrl)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.play()
            }
            catch let error {
                print(error.localizedDescription)
            }
            
        } else {
            print("audio file is not found")
        }
    }
    
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        arView.addGestureRecognizer(tap)
    }
    
 
    
    func setupMultipeerSession() {
        if(self.multipeerSession != nil) {
            self.sendARSessionIDTo(peers: multipeerSession.connectedPeers)
        }
        multipeerSession = MultipeerSession(receivedDataHandler: receivedData, peerJoinedHandler: peerJoined, peerLeftHandler: peerLeft, peerDiscoveredHandler: peerDiscovered)
        
        guard let syncService = self.multipeerSession.syncService else {
            fatalError("could not create multipeerHelp.syncService")
        }
        arView.scene.synchronizationService = syncService

        
        
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mode(mode:PlayingMode) {
        allowComputerPlay = false
        allowMultipeerPlay = false
        if(mode == .Computer) {allowComputerPlay = true}
        else if(mode == .MultiDevice) {allowMultipeerPlay = true}
        restartGame()
    }
    func play() {
        restartGame()
    }
   /*
     func setupChessEngine() {
     
     }
 
     
     func computerMove() {
     
     }
 */
    
    func restartGame() {
        resetBoard()
        curColor = "w"
        recordBanner.text = ""
        fenBanner.text = ""
        banner.text = "Tap on a horizontal surface to place chessboard"
        peerIdLabel.text = ""
        peerIdLabel.backgroundColor = .clear
        sessionInfoLabel.text = ""
        selectedPiece = nil
        startPosXY = (-1,-1)
        endPosXY = (-1,-1)
        if(multipeerSession != nil && !multipeerSession.connectedPeers.isEmpty) {
            guard let myData = "left".data(using: .ascii) else {
                return
            }
            multipeerSession.sendToAllPeers(myData)
            multipeerSession.disconnect()
        }
        multipeerSession = nil
        if(allowMultipeerPlay) {
            setupMultipeerSession()
            banner.text = "Wait for participants to join"
        }
        if(allowComputerPlay) {
            banner.text = "Tap on a horizontal surface to place chessboard"
            setupChessEngine()
        }
    }
    
    
    
    
    
    func setupAll () {
        setupViews()
        setupARconfig()
        setupGestures()
        if(allowMultipeerPlay) {setupMultipeerSession()}
        if(allowComputerPlay) {setupChessEngine()}
        setupChessBoard()
        //setupASCIIBoard()
        banner.text = "Select mode to play or tap on a horizontal surface to place chessboard"
        //presentCoachingOverlay()
    }
    
    func setupARconfig () {
        // Configure the AR session for horizontal plane tracking.
        let arConfiguration = ARWorldTrackingConfiguration()
        arConfiguration.planeDetection = .horizontal
        arConfiguration.isLightEstimationEnabled = true
        arConfiguration.isCollaborationEnabled = true
        arView.debugOptions = [.showFeaturePoints]
        //arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        arView.session.run(arConfiguration)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAll()
    }
    
    override public var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        arView = ARView.init(frame: UIScreen.main.bounds, cameraMode: .ar, automaticallyConfigureSession: true)
        self.view = arView
        arView.session.delegate = self

    }
    
    
    func id(str: String) -> String {
        let start = str.firstIndex(of: "=") ?? str.endIndex
        return String(str[start..<str.endIndex])
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if(allowMultipeerPlay && multipeerSession.connectedPeers.isEmpty) {return}
        if(!finishedAnalyzing) {
            alertController.message = "Wait for computer"
            playSound(sound: 0)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if(allowMultipeerPlay && peerToPlay) {
            if(self.owner) {alertController.message = "Wait for black to play"}
            else {alertController.message = "Wait for white to play"}
            playSound(sound: 0)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        recordBanner.isHidden = false
        fenBanner.isHidden = false
        
        var col: Color = .black
        if(curColor == "w") {col = .white}
        if(computerPlays && allowComputerPlay) {return}
        guard let touchInView = sender?.location(in: self.arView) else {
            return
        }
        sessionInfoLabel.text = ""
        let allowing: ARRaycastQuery.Target = .existingPlaneGeometry
        //if(self.game != nil) {allowing = .estimatedPlane}
        if let result = arView.raycast(
            from: touchInView,
            allowing: allowing,
            //allowing:. existingPlaneGeometry,
            alignment: .horizontal
        ).first {
            if(!modelTapped && !planeAnchorAdded) {
                if(!allowMultipeerPlay || ((multipeerSession != nil) &&
                    connectedWithPeer &&
                    (!multipeerSession.connectedPeers.isEmpty &&
                        (multipeerSession.clientPeerID != multipeerSession.myPeerID)))) {
                    planeAnchor = ARAnchor(name: "Base", transform: result.worldTransform)
                    self.arView.session.add(anchor: self.planeAnchor)
                    banner.text = "White to move- tap a piece to select"
                    fenBanner.text = "position fen "+get_fen(arr:position)+" "+curColor+" "+castling+" -"
                    
                    self.owner = true
                    
                    if(allowMultipeerPlay && !multipeerSession.connectedPeers.isEmpty) {
                        peerIdLabel.text = id(str: "\(String(describing: multipeerSession.clientPeerID))")
                        if(self.owner) {
                            banner.text = "You are white"
                            peerToPlay = false
                        }
                        else {
                            banner.text = "You are black"
                            peerToPlay = true
                        }
                        idLabel.backgroundColor = .green
                        peerIdLabel.backgroundColor = .green
                    }
                }
                modelTapped = true
                return
            }
            if(self.game == nil) {return}
            guard let entities = self.arView?.entities(
                at: touchInView
                )  else {
                    // no entity was hit
                    return
            }
            for entity in entities {
                let entityName = pieceName(str:entity.name)
                if((selectedPiece != nil) && (isPiece(entity:entity)
                    && (entity2color(str:selectedPiece.name) == entity2color(str: entityName)))){
                    alertController.message = selectedPiece.name+" already selected"
                    self.present(alertController, animated: true, completion: nil)
                    playSound(sound: 0)
                    return
                }
                if(isPiece(entity:entity) && selectedPiece == nil && (entity2color(str: entityName) != col)) {
                    if(curColor == "w") {alertController.message = "Whites turn to play"}
                    else {alertController.message = "Blacks turn to play"}
                    self.present(alertController, animated: true, completion: nil)
                    playSound(sound: 0)
                    selectedPiece = nil
                    return
                }
                if(isPiece(entity:entity) && selectedPiece == nil && (entity2color(str: entityName) == col)) {
                    selectedPiece = board2piece(str:entity.name)
                    let (xs, zs) = board2position(str:entity.name)
                    startPosXY = (xs, zs)
                    moves = validMoves(x: xs, y: zs)
                    if (moves.count == 0) {
                        alertController.message = pieceType(str:selectedPiece.name) + "  cannot be moved"
                        self.present(alertController, animated: true, completion: nil)
                        playSound(sound: 0)
                        selectedPiece = nil
                        return
                    }
                    removeOverlay()
                    displayValidMoves(x: xs, y: zs)
                    displayCell(x: xs, y: zs)
                    if(allowMultipeerPlay) {
                        guard let myData = highlightCommand(coords: moves).data(using: .ascii) else {
                            return
                        }
                        multipeerSession.sendToAllPeers(myData)
                    }
                    banner.text = "Tap on board to place piece"
                    return
                }
                if((selectedPiece != nil) && !selectedBoard &&
                    // either its an empty board or the piece is opposite color for capture
                    (isBoard(entity:entity) ||
                        (entity2color(str: entityName) != entity2color(str: selectedPiece.name)))) {
                    endPosXY = board2position(str:entity.name)
                    selectedBoard = true
                    break
                }
            }
            for entity in entities {
                if(selectedPiece == nil && !isPiece(entity:entity) && isBoard(entity:entity)) {
                    alertController.message = "Select piece first"
                    if(curColor == "w") {alertController.message=alertController.message!+" (white to play)"}
                    else {alertController.message=alertController.message!+" (black to play)"}
                    playSound(sound: 0)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
            
            if(!selectedBoard || (selectedPiece == nil)) {return}
            if(!isValidMove(coord: (endPosXY.0, endPosXY.1), coords: moves)) {
                selectedBoard = false
                return
            }
            movePiece(sx: startPosXY.0, sy: startPosXY.1, tx: endPosXY.0, ty: endPosXY.1)
            
            
            selectedPiece = nil
            selectedBoard = false
            moves=[]
            if(allowComputerPlay || !allowMultipeerPlay) {
                if(curColor == "w"){curColor = "b"}
                else {curColor = "w"}
                if(curColor == "w") {
                    banner.text = "White to play"
                } else {
                    banner.text = "Black to play"
                }
            }
            if(allowComputerPlay) {
                computerPlays = true
                banner.text = banner.text! + "(Computer)"
                idLabel.backgroundColor = .red
                computerMove()
                idLabel.backgroundColor = .green
            } else if (!allowMultipeerPlay) {
                banner.text = banner.text! + " tap a piece to select"
                
            } else {
                if(self.owner) {curColor = "w"}
                else {curColor = "b"}
                
                if(!multipeerSession.connectedPeers.isEmpty) {
                    if(self.owner) {banner.text = "You are white"}
                    else {banner.text = "You are black"}
                    peerIdLabel.backgroundColor = .green
                    idLabel.backgroundColor = .green
                    guard let myData = "move \(startPosXY.0),\(startPosXY.1) \(endPosXY.0),\(endPosXY.1)".data(using: .ascii) else {
                        return
                    }
                    multipeerSession.sendToAllPeers(myData)
                    peerToPlay = true
                    
                }
            }
            recordBanner.text = recordString
            fenBanner.text = "position fen "+get_fen(arr:position)+" "+curColor+" "+castling+" -"
            sessionInfoLabel.text = ""
        }
    } 
}



