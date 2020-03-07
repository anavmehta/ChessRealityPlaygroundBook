//: [Previous](@previous)
/*:
 # Play with the computer
  Select "Play with computer" from liveView or mode
 Use the green hint button "?" for analysis of best move
 Enjoy! 😊
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
var bestMove = analyze()
move(bestMove)
color("b")
bestMove = analyze()
move(bestMove)
color("w")
bestMove = analyze()
move(bestMove)
//#-end-editable-code
