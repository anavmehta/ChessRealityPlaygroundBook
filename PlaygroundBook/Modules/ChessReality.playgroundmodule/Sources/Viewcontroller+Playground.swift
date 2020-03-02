//
//  ViewController+Playground.swift
//  ChessReality
//
//  Created by Anav Mehta on 2/20/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

import PlaygroundSupport

//extension ViewController : PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer{
extension ViewController {//}: PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer{
    public func liveViewMessageConnectionOpened() {}
    
    public func liveViewMessageConnectionClosed() {}
    
    public func receive(_ message: PlaygroundValue) {
        var sx: Int! = -1
        var sy: Int! = -1
        var tx: Int! = -1
        var ty: Int! = -1
        var status: Int! = -1
        switch message {
        case let .string(text):
            let strArr = text.split(separator: " ")
            switch strArr[0] {
            case "play":
                play()
            case "analyze":
                //(sx!,sy!,tx!,ty!) = analyze()
                self.send(.string("analyze " + String(sx!) + " " + String(sy!) + " " + String(tx!) + " " + String(ty!)))
            case "sound":
                if(strArr[1] == "true") {sound(enabled: true)}
                else {sound(enabled: false)}
            case "animation":
                if(strArr[1] == "true") {animation(enabled: true)}
                else {animation(enabled: false)}
            case "move":
                _ = move(str: String(strArr[1]))
            case "tap":
                tap(str: String(strArr[1]))
            default:
                print("Not a recognized command")
            }
        default:
            print("A valid message not received")
        }
        
    }
    
}

