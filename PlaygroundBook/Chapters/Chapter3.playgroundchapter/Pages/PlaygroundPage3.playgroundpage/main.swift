//: [Previous](@previous)
/*:
 # Play with another device
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
mode(.Computer)
wait()
puzzle(1)
color("b")
var bestMove = analyze()
move(bestMove)
color("w")
bestMove = analyze()
move(bestMove)


//#-end-editable-code
