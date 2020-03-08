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
//#-code-completion(everything, hide)
//#-code-completion(currentmodule, show)
//#-code-completion(identifier, show, true, false)
/*:
# Play
 - play()
 The playground or live view starts in basic play mode. However, if you have to reset the game. You can use the play() function.
*/
play()
/*:
# Turn on or off the sound:
- sound(soundEnabled)
   - soundEnabled: [false, true]
*/
/*:
# Mode of the game:
- mode(playingMode)
   - playingMode: [PlayingMode.SingleDevice,PlayingMode.Computer,PlayingMode.MultiDevice]
*/
mode(/*#-editable-code set x*/.SingleDevice/*#-end-editable-code*/)
/*:
# Turn on or off the sound:
- sound(soundEnabled)
   - soundEnabled: [false, true]
*/
sound(/*#-editable-code sound enabled**/true/*#-end-editable-code*/)
/*:
# Turn on or off the sound:
- animation(animatonEnabled)
   - animationEnabled: [false, true]
*/
animation(/*#-editable-code animation enabled**/true/*#-end-editable-code*/)
/*:
# Wait for the chess board to be anchored. If the board is already anchored it returns immediately, or waits for the board to be anchored
- wait()
*/
wait()

/*:
# Tap on the location of the board.
    On the first tap, if the location has a piece which has valid moves the valid moves are highlighted and the piece is selected.
    On the second tap if there is a piece selected and the new location is valid (ie part of the valid moves) it is moved. If the new location has a piece of opposite color it is captured.
- tap(location)
   - location: Algebraic location of the board from [a-h][1-8]
*/
tap(/*#-editable-code tap location*/"e2"/*#-end-editable-code*/) //taps and selects pawn at e2
tap(/*#-editable-code tap location*/"e4"/*#-end-editable-code*/) //second tap moves the piece to e4
/*:
# Move a piece.
 This performs the two tap process to move the piece. The start_location and end_location correspond to the first and second tap respectively
 - move(start_location+end_location)
    - start_location: Start Algebraic location of the board from [a-h][1-8]
    - end_location: End Algebraic location of the board from [a-h][1-8]
*/
move(/*#-editable-code move locations*/"e7e5"/*#-end-editable-code*/)
/*:
# Analyze a move. You can click on the "bulb" symbol and get a hint. The hint will highlight the start_location and the end_location
 - bestMove = analyze()
    - This performs an analysis on the chess board with the current player (color)
    - The return value is in the Algebraic form of Algebraic "start_location"+"end_location" which can be used in move() function. 
*/
var bestMove = analyze()
move(bestMove)
/*:
# Color of current player
 In general you dont need to set this. For for analysis you can override the current color
 - color(colorStr)
    - colorStr: "w" - White
                "b" - Black
 */
color("b")
bestMove = analyze()
//#-editable-code
//#-end-editable-code
