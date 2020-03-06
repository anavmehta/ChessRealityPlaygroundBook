//: [Previous](@previous)
/*:
 # Play with the computer
 Select "Play with another device" from liveView or mode
 Pair with another device - you id and your peerid will turn green
 Tap on your device to place chessboard
 The first one who places the board plays white and first move
 Enjoy! 😊
 */
//: [Next](@next)
//#-hidden-code
import PlaygroundSupport
import Foundation
import ChessReality
PlaygroundListener.shared.setup()
//#-end-hidden-code
//#-editable-code
mode(.Computer)
wait()
//#-end-editable-code
