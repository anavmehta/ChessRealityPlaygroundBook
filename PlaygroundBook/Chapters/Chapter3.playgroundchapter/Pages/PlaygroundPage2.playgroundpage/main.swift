//: [Previous](@previous)
/*:
 # ChessEngine in Playground
 - Use chessengine via analyze() function in playgorund or hint **bulb** button in liveview. 
 - Remember:
    - Press **Run My Code** and use **landscape** for best experience.
    - Move your camera before tapping for board placement for better detection of horizontal feature points.
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
