//: [Previous](@previous)
/*:
 # Computer+Playground
 Use the power of the chess engine to determine next moves in the playground
 */
//: [Next](@next)
//#-hidden-code
import PlaygroundSupport
import Foundation
import ChessReality
PlaygroundListener.shared.setup()
//#-end-hidden-code
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
//#-editable-code
//#-end-editable-code
