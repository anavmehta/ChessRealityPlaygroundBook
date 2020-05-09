/*:
 # Introduction to ChessReality
 Find a 20cmx20cm horizontal surface to place the chess board on. As you point your camera on a horizontal surface, the detected raw feature debug points per frame will focus and you can then place the board with a tap. After the board is placed, a single tap will select a piece and the second tap will place the piece. When a piece is selected, the available moves will be highlighted. When you capture a piece, it is removed from the board.
 You an either play the game in SingleDevice, Computer or with another player in Multipeer mode - with another device with the same playgroundbook.
 - Remember:
    - Press **Run My Code** and use **landscape** for best experience.
    - Move your camera before tapping for board placement for better detection of horizontal feature points.
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
//#-editable-code
//#-end-editable-code
