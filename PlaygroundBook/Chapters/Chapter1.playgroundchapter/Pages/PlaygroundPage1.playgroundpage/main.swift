/*:
 # Introduction to ChessReality
 It is the classic chess game of chess using Augmented Reality.
 First find a 20cmx20cm flat surface to place the chess board on. As you point your camera on a horizontal surface, the raw feature debug points it detects per frame will focus and you can then place the board with a tap. After the board is placed, a single tap will select a piece and the second tap will place the piece. When a piece is selected, the available moves will be highlighted. When you capture a piece, it is removed from the board.
 You an either play the game in SingleDevice, Computer or with another player in Multipeer mode - with another device with the same playgroundbook.
 
 
 Enjoy! 😊
 */
//: [Next](@next)
//#-hidden-code
import PlaygroundSupport
import Foundation
import ChessReality
PlaygroundListener.shared.setup()
//#-end-hidden-code
play()
