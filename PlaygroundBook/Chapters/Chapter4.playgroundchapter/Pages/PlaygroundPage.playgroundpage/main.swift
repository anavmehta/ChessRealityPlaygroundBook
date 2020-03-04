//: [Previous](@previous)
/*:
 # Play with the computer
 Select "Play with another device" from live view or use setMode
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
setMode(mode:.Computer)
wait()
let bestMove = analyze()
//#-end-editable-code
