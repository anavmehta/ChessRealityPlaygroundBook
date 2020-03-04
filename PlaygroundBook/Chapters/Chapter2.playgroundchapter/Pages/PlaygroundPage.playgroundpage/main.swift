//: [Previous](@previous)
/*:
 # Play Progammatically
A few functions were defined to use for the
 - play() - starts the game
 - sound(enabled: Bool) - enables or disables the sound
 - animation(enabled: Bool) - enables or disables the animation
 - tap(str:str) - taps the piece at position [a-h][1-8]
 - move(str:str) moves the piece from position [a-h][1-8] -> [a-h][1-8]
 Enjoy! 😊
 */
//: [Next](@next)
//#-hidden-code
import PlaygroundSupport
import Foundation
import ChessReality
PlaygroundListener.shared.setup()
//#-end-hidden-code
//#-editable-code
sound(enabled: true)
animation(enabled: true)
wait()
tap(str:"a2") //taps and selects pawn at a2
tap(str:"a4") //second tap moves the piece to a4
move(str:"a7a5")
//#-end-editable-code