//: [Previous](@previous)
/*:
 # Computer+Playground
 - Use the power of the chess engine to determine best next moves in the playground.
 - Use the hint button to explore the best move.
 - Use the analyze() function in the playground
 - Remember:
    - Press **Run My Code** and use **landscape** for best experience.
    - Move your camera around to help detection of horizontal feature points for better board placement.
 */
//: [Next](@next)
//#-hidden-code
import PlaygroundSupport
import Foundation
import ChessReality
PlaygroundListener.shared.setup()
//#-end-hidden-code
mode(.SingleDevice)
wait()
var bestMove = analyze()
move(bestMove)
color("b")
bestMove = analyze()
move(bestMove)
color("w")
bestMove = analyze()
move(bestMove)
//#-editable-code
//#-end-editable-code
