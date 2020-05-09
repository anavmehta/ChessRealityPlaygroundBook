//: [Previous](@previous)
/*:
 # Play with another device
 - Press **Run My Code** or "Play With Opponent" from LiveView and use **landscape** for best experience.
 - Pair with another device - your id and your peerid will turn green when you pair.
 - Move your camera before tapping for board placement for better detection of horizontal feature points.
 - The first one who places the board plays white.
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
