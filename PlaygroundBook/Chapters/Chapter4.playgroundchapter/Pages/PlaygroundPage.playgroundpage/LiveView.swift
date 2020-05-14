//
//  LiveView.swift
//  ChessReality
//
//  Created by Anav Mehta on 3/5/20.
// Copyright (c) 2020 Anav Mehta. All rights reserved
//


import UIKit
import ChessReality
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
let liveView = ViewController()
//liveView.allowMultipeerPlay = true
//liveView.restartGame()
liveView.customSC.isHidden = true
PlaygroundPage.current.liveView = liveView
