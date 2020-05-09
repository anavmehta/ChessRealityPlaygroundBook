//: [Previous](@previous)
/*:
 # Play Chess Puzzles puzzle()
 - Remember:
    - Press **Run My Code** and use **landscape** for best experience.
    - Move your camera before tapping for board placement for better detection of horizontal feature points.
    - You can use the "Hint" bulb.
 */
//: [Next](@next)
//#-hidden-code
import PlaygroundSupport
import Foundation
import ChessReality
PlaygroundListener.shared.setup()
//#-end-hidden-code
/*:
 - puzzle(puzzle_number)
    - puzzle_number:
        - 0 : No puzzle
        - 1 : James Mason vs. Georg Marco The game between James Mason (white) and Georg Marko, Leipzig 1894, ended with a spectacular victory in two for the black.
        - 2 : Enrico Paoli vs. Jan Foltys. This is the end game between Italian International chess master Enrico Paoli and the Czech Internation.  Jan Foltys, Trencianske Teplice,1949. Find the solution for back to win in 2.
 - Remember you can use the "*Hint*" bulb.

*/
mode(.SingleDevice)
puzzle(/*#-editable-code puzzle_number*/1/*#-end-editable-code*/)
wait()
color("b") //black to move
//#-editable-code
//Find the best move or uncomment the lines below the see what the chess engine discovers
//var bestMove = analyze()
//move(bestMove)
//color("w") // white to move
//#-end-editable-code
