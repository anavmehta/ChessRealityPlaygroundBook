//: [Previous](@previous)
/*:
 # Chess Puzzle 2 - Enrico Paoli vs. Jan Foltys
 This is the end game between Italian International chess master Enrico Paoli and the Czech International chess master  Jan Foltys, Trencianske Teplice,1949. Find the solution for back to win in 2.
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
puzzle(2)
color("b")
var bestMove = analyze()
move(bestMove)
color("w")
bestMove = analyze()
move(bestMove)


//#-end-editable-code
