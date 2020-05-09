/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 Extensions for the sample app's main view controller to handle ARAnchor placement
 */

import UIKit
import ARKit
import RealityKit
import MultipeerConnectivity


/// Used to display the coaching overlay view and kick-off the search for a horizontal plane anchor.
extension ViewController: ARCoachingOverlayViewDelegate {
    public func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        /*
        // Ask the user to gather more data before placing the game into the scene
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Set the view controller as the delegate of the session to get updates per-frame
            self.arView.session.delegate = self
        }*/
    }
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
    }
}

extension ViewController: ARSessionDelegate {
    
    
    
    public func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let _ = anchor as? ARParticipantAnchor {
                sessionInfoLabel.text="Established joint experience with a peer."
                banner.text="Move around and tap on screen to place chessboard"
                connectedWithPeer = true
                peerIdLabel.text = id(str: "\(String(describing: multipeerSession.clientPeerID))")
                peerIdLabel.backgroundColor = .green
                idLabel.backgroundColor = .green
                
            } else if anchor.name == "Base" {
                sessionInfoLabel.text="Added plane anchor"
                if(self.owner) {
                    banner.text = "You are white - your turn to play"
                    peerToPlay = false
                }
                else {
                    banner.text = "You are black"
                    peerToPlay = true
                }
                let anchorEntity = AnchorEntity(anchor: anchor)
                planeAnchorAdded = true
                if(self.game != nil) {anchorEntity.addChild(self.game)}
                curColor = "b"
                if(self.owner) {curColor = "w"}
                arView.scene.addAnchor(anchorEntity)
                idLabel.backgroundColor = .green
                removeCoachingOverlay()
            }
            
        }
    }
    
    public func session(_ session: ARSession, didUpdate frame: ARFrame) {
        updateSessionInfoLabel(for: frame, trackingState: frame.camera.trackingState)
        
    }
    
    // MARK: - ARSessionDelegate
    /// - Tag: PeerJoined
    public func peerJoined(_ peer: MCPeerID) {
        sendARSessionIDTo(peers: [peer])
    }
    
    public func peerLeft(_ peer: MCPeerID) {
        peerSessionIDs.removeValue(forKey: peer)
    }
    
    public func sendARSessionIDTo(peers: [MCPeerID]) {
        guard let multipeerSession = multipeerSession else { return }
        print("Sending ARSessionID to peers...")
        let idString = arView.session.identifier.uuidString
        let command = "SessionID:" + idString
        if let commandData = command.data(using: .utf8) {
            multipeerSession.sendToPeers(commandData, reliably: true, peers: peers)
        }
    }
    
    public func peerDiscovered(_ peer: MCPeerID) -> Bool {
        guard let multipeerSession = multipeerSession else { return false }
        
        if multipeerSession.connectedPeers.count > 2 {
            return false
        } else {
            return true
        }
    }
    
    // MARK: - AR session management
    
    private func updateSessionInfoLabel(for frame: ARFrame, trackingState: ARCamera.TrackingState) {
        var message: String = sessionInfoLabel.text ?? ""
        
        switch trackingState {
        case .normal where allowMultipeerPlay && frame.anchors.isEmpty && multipeerSession.connectedPeers.isEmpty:
            // No planes detected; provide instructions for this app's AR interactions.
            message = "Start to play with computer, or wait to join a shared session."
            
        case .normal where allowMultipeerPlay && !multipeerSession.connectedPeers.isEmpty && mapProvider == nil:
            let peerNames = multipeerSession.connectedPeers.map({ $0.displayName }).joined(separator: ", ")
            message = "Connected with \(peerNames)."
            connectedWithPeer = true
            idLabel.backgroundColor = .green
            peerIdLabel.text = id(str:"\(String(describing: multipeerSession.clientPeerID))")
            peerIdLabel.backgroundColor = .green
            
            
        case .notAvailable:
            message = "Tracking unavailable."
            
        case .limited(.excessiveMotion):
            message = "Tracking limited - Move the device more slowly."
            
        case .limited(.insufficientFeatures):
            message = "Tracking limited - Point the device at an area with visible surface detail, or improve lighting conditions."
            
        case .limited(.initializing) where mapProvider != nil,
             .limited(.relocalizing) where mapProvider != nil:
            message = "Received map from \(mapProvider!.displayName)."
            
        case .limited(.relocalizing):
            message = "Resuming session — move to where you were when the session was interrupted."
            
        case .limited(.initializing):
            message = "Initializing AR session."
            
        default:
            message = ""
        }
        sessionInfoLabel.text = message
    }
    
    public func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        updateSessionInfoLabel(for: session.currentFrame!, trackingState: camera.trackingState)
    }
    
    /// Begins the coaching process that instructs the user's movement during
    /// ARKit's session initialization.
    
    func presentCoachingOverlay() {
        coachingOverlay.session = arView.session
        coachingOverlay.delegate = self
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.activatesAutomatically = false
        self.coachingOverlay.setActive(true, animated: true)
    }

    func removeCoachingOverlay() {
        // Remove the coaching overlay view
        arView.debugOptions = []
        self.coachingOverlay.delegate = nil
        self.coachingOverlay.setActive(false, animated: false)
        self.coachingOverlay.removeFromSuperview()
    }
    
    /// - Tag: ReceiveData
    func receivedData(_ data: Data, from peer: MCPeerID) {
        mapProvider = peer
        
        let sessionIDCommandString = "SessionID:"
        if let commandString = String(data: data, encoding: .utf8), commandString.starts(with: sessionIDCommandString) {
            let newSessionID = String(commandString[commandString.index(commandString.startIndex,
                                                                        offsetBy: sessionIDCommandString.count)...])
            peerSessionIDs[peer] = newSessionID
            return
        }
        let str = String(data: data, encoding: .ascii) ?? "Data is not an ASCII string"
        interpretCommand(str:str)
        peerToPlay = false
    }
    
    
    
    // MARK: - ARSessionObserver
    
    public func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay.
        sessionInfoLabel.text = "Session was interrupted"
    }
    
    public func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required.
        sessionInfoLabel.text = "Session interruption ended"
    }
    
}

