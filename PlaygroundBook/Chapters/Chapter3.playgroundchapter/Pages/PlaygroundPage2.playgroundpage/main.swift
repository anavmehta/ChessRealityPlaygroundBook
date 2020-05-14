//: [Previous](@previous)
/*:
 # ChessEngine in Playground
 - Use chessengine via analyze() function in playgorund or hint **bulb** button in liveview. 
 - Remember to press **Run My Code** and use **landscape** for best experience. And move your camera before tapping for board placement for better detection of horizontal feature points. If you need a hint use the **yellow bulb** button. Enjoy! 😊
 */
//: [Next](@next)
//#-hidden-code
import PlaygroundSupport
import Foundation
import ChessReality
PlaygroundListener.shared.setup()
//#-end-hidden-code
mode(.SingleDevice)
wait_for_anchor()
var best_move = analyze()
move(best_move)
// The next two analyzes and moves for black
best_move = analyze()
move(best_move)
// The next two analyzes and moves for white
best_move = analyze()
move(best_move)
//#-editable-code
//#-end-editable-code
