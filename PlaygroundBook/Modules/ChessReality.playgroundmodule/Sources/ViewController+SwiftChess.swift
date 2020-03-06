//
//  ViewController+SwiftChess.swift
//  ChessReality
//
//  Created by Anav Mehta on 3/5/20.
// Copyright (c) 2020 Anav Mehta. All rights reserved
//


import Foundation
import SwiftChess



extension ViewController {
    func makeGameWithBoard(board: Board, colorToMove: SwiftChess.Color) -> Game {
        
        let whitePlayer = AIPlayer(color: .white, configuration: AIConfiguration(difficulty: .hard))
        let blackPlayer = AIPlayer(color: .black, configuration: AIConfiguration(difficulty: .hard))
        
        let game = Game(firstPlayer: whitePlayer, secondPlayer: blackPlayer, board: board, colorToMove: colorToMove)
        
        return game
    }
    
    func get_ASCIIBoard(arr: [[String]]) -> String {
        var fen: String = ""
        var sq: String
        
        for row in 0...7 {
            for col in 0...7 {
                sq = arr[col][row]
                if (sq == "empty" || sq == "" || sq == " ") {
                    fen=fen+"-"
                } else {
                    let start = sq.index(sq.startIndex, offsetBy: 1)
                    let end = sq.index(sq.startIndex, offsetBy: 2)
                    var c = sq[start..<end]
                    if (c == "k") {c = "g"}
                    else if (c == "n") {c = "k"}
                    if(sq.prefix(1) == "b") {
                        fen += c
                    } else {
                        fen += c.uppercased()
                    }
                }
                if(col < 7) {fen += " "}
            }
        }
        return fen
    }
    

    func setupASCIIBoard() {
        /*
        let board = ASCIIBoard(pieces: "r k b q g b k r" +
                                       "p p p p p p p p" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "- - - - - - - -" +
                                       "P P P P P P P P" +
                                       "R K B Q G B K R" )*/
    /*    let board = ASCIIBoard(pieces: "- - - - - - p g" +
                                       "- - - b - - p p" +
                                       "- - - - q - - -" +
                                       "- B p k P p - -" +
                                       "- - - P Q - - -" +
                                       "- - - - - - - -" +
                                       "P P - - - - - -" +
                                       "G P - - - - - -" ) */
        let board = ASCIIBoard(pieces: get_ASCIIBoard(arr:position))
        
        let game = makeGameWithBoard(board: board.board, colorToMove: .white)
        self.computer = game
        game.delegate = self
        self.computer.board.printBoardState()
        guard let player = game.currentPlayer as? AIPlayer else {
            return
        }
        
        //player.makeMoveSync()
        player.makeMoveAsync()
    }
    
    func analyze() -> (Int, Int, Int, Int) {
        var colorToMove: SwiftChess.Color
        if(!planeAnchorAdded) {return (-1,-1,-1,-1)}
        if(selectedPiece != nil) {
            alertController.message = "Piece aleady selected tap to place"
            playSound(sound: 0)
            self.present(alertController, animated: true, completion: nil)
            return (-1,-1,-1,-1)
        }
        setupChessEngine()
        let board = ASCIIBoard(pieces: get_ASCIIBoard(arr:position))
        if(curColor == "w") {colorToMove = SwiftChess.Color.white}
        else {colorToMove = SwiftChess.Color.black}
        let chessgame = makeGameWithBoard(board: board.board, colorToMove: colorToMove)
        self.computer = chessgame
        chessgame.delegate = self
        //self.computer.board.printBoardState()
        guard let player = chessgame.currentPlayer as? AIPlayer else {
            return (-1,-1,-1,-1)
        }
        player.makeMoveAsync()
        CFRunLoopRun()
        removeOverlay()
        //let (sx, sy, tx, ty) = translateMove(move: bestMoveNext)
        displayCell(x: startPosXY.0, y: startPosXY.1)
        displayCell(x: endPosXY.0, y: endPosXY.1)
        return(startPosXY.0, startPosXY.1, endPosXY.0, endPosXY.1)
    }
    
    func computerMove() {
        if(!computerPlays && allowComputerPlay) {return}
        (_,_,_,_) = analyze()
        removeOverlay()
        displayMove()
        if(curColor == "w"){curColor = "b"}
        else {curColor = "w"}
        if(curColor == "b") {
            banner.text = "Black to play "
        } else {
            banner.text = "White to play"
        }
        computerPlays = false
    }

    func setupChessEngine() {
        let whitePlayer = Human(color: .white)
        let blackPlayer = AIPlayer(color: .black, configuration: AIConfiguration(difficulty: .hard))
        
        let game = Game(firstPlayer: whitePlayer, secondPlayer: blackPlayer)
        self.computer = game
        computer.delegate = self

    }
    
    public func gameWillBeginUpdates(game: Game) {
        // Do nothing
    }
    
    public func gameDidAddPiece(game: Game) {
        // Do nothing
    }
    public func gameDidChangeCurrentPlayer(game: Game) {
        
    }
    
    public func gameWonByPlayer(game: Game, player: Player) {
        
    }
    
    public func gameEndedInStaleMate(game: Game) {
        
    }
    
    
    
    public func gameDidRemovePiece(game: Game, piece: SwiftChess.Piece, location: BoardLocation) {
        
    }
    
    func index2pos(index: Int) -> (Int, Int) {
        let y = 7-index/8
        let x = index % 8
        return (x, y)
    }
    
    public func gameDidMovePiece(game: Game, piece: SwiftChess.Piece, toLocation: BoardLocation) {
        startPosXY = index2pos(index: piece.location.index)
        endPosXY = index2pos(index: toLocation.index)
        CFRunLoopStop(runLoop)
        //game.board.printBoardState()
    }
    
    public func gameDidTransformPiece(game: Game, piece: SwiftChess.Piece, location: BoardLocation) {
        
    }
    
    public func gameDidEndUpdates(game: Game) {
        
    }
    public func promotedTypeForPawn(location: BoardLocation, player: Human, possiblePromotions: [SwiftChess.Piece.PieceType], callback: @escaping (SwiftChess.Piece.PieceType) -> Void) {
    
    }

    /*
    public func promotedTypeForPawn(location: BoardLocation, player: Human, possiblePromotions: [Piece.PieceType], callback: @escaping (Piece.PieceType) -> Void) {
        
    }*/
/*
    func startAnalysis() {
        finishedAnalyzing = false
        engineManager.gameFen = gameFen
        engineManager.startAnalyzing()
        let time = DispatchTime.now() + DispatchTimeInterval.seconds(1)
        DispatchQueue.global().asyncAfter(deadline: time, execute: {
                self.engineManager.stopAnalyzing()
        })
    }
*/

}




