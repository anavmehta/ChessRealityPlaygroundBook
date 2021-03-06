//: [Previous](@previous)
/*:
 # Play Chess Puzzles puzzle()
 Remember to press **Run My Code** and use **landscape** for best experience. And move your camera before tapping for board placement for better detection of horizontal feature points. If you need a hint use the **yellow bulb** button. Enjoy! 😊
 */
//: [Next](@next)
//#-hidden-code
import PlaygroundSupport
import Foundation
import ChessReality
PlaygroundListener.shared.setup()
//#-end-hidden-code
/*:
 - puzzle(_ puzzle_number: Int))
    - puzzle_number: [0,1,2]
        - 0 : No puzzle
        - 1 : James Mason vs. Georg Marco, Leipzig 1894. Black to play and win in 2.
        - 2 : Enrico Paoli  vs. Jan Foltys, Trencianske Teplice 1949. Black to play and win in 2.
*/
mode(.SingleDevice)
puzzle(/*#-editable-code puzzle_number*/1/*#-end-editable-code*/)
wait_for_anchor()
color("b") //black to move
//#-editable-code
//Find the best move or uncomment the lines below the see what the chess engine discovers
//var best_move = analyze()
//move(best_move)
//#-end-editable-code
