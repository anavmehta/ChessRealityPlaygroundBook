//: [Previous](@previous)
/*:
 # Play with another device
 Select "Play with another device" from live view or use mode. 
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
mode(.MultiDevice)
wait()
//#-editable-code
// You can write your own code with analyze() and move() to play against your opponent
//#-end-editable-code
