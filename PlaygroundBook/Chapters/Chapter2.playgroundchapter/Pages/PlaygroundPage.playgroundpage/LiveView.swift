//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Instantiates a live view and passes it to the PlaygroundSupport framework.
//

import UIKit
import ChessReality
import PlaygroundSupport

// Instantiate a new instance of the live view from BookCore and pass it to PlaygroundSupport.
//PlaygroundPage.current.liveView = instantiateLiveView()
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = ViewController()
