//: [Previous](@previous)
/*:
 # Introduction to ChessReality
 - Move your camera and debug feature points will help you place a 20cmx20cm chessboard with a tap on a horizontal surface. A single tap will select a piece displaying the legal moves and a second tap will place the piece.
 - Use the top menu buttons to play in SingleDevice, Computer or MultiDevice mode with another player with a device on the same wifi using the same playground.
 - Remember to press **Run My Code** and use **landscape** for best experience. And move your camera before tapping for board placement for better detection of horizontal feature points. If you need a hint use the **yellow bulb** button.
 Enjoy! 😊
  */
//: [Next](@next)
//#-hidden-code
import PlaygroundSupport
import Foundation
import ChessReality
PlaygroundListener.shared.setup()
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(currentmodule, show)
//#-code-completion(identifier, show, true, false)
play()
wait_for_anchor()
//#-editable-code
//#-end-editable-code
