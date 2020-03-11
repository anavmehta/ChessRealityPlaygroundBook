//: [Previous](@previous)
/*:
 # Play Progammatically
A few functions were defined to use for the
 - play()
    - Starts or resets the game in the mode it was set to.
 - mode(_ mode: PlayingMode)
    - Sets the game to either .SingleDevice, .Computer or .MultiDevice
 - sound(_ enabled: Bool)
    - Turn on or off the sound
 - animation(_ enabled: Bool)
    - enables or disables the animation
 - tap(_ position: String)
    - taps the piece at position (Algebraic Notation) [a-h][1-8].
 - move(_ move: String)
    - moves the piece from position (Algebraic Notation) [a-h][1-8] to position [a-h][1-8].
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
    - This starts or resets the game in the mode it was set to.
*/
play()
/*:
# Turn on or off the sound:
- sound(_ enabled: Bool)
   - enabled: [false, true]
*/
/*:
# Mode of the game:
- mode(_ playingMode: PlayingMode)
   - playingMode: [PlayingMode.SingleDevice,PlayingMode.Computer,PlayingMode.MultiDevice]
*/
mode(/*#-editable-code set x*/.SingleDevice/*#-end-editable-code*/)
/*:
# Turn on or off the sound:
- sound(_ enabled: Bool)
   - enabled: [false, true]
*/
sound(/*#-editable-code sound enabled**/true/*#-end-editable-code*/)
/*:
# Turn on or off the animation:
- animation(_ enabled: Bool)
   - enabled: [false, true]
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
- tap(_ position: String)
   - position: Algebraic location of the board from [a-h][1-8]
*/
tap(/*#-editable-code tap location*/"e2"/*#-end-editable-code*/) //taps and selects pawn at e2
tap(/*#-editable-code tap location*/"e4"/*#-end-editable-code*/) //second tap moves the selected pawn to e4
/*:
# Move a piece.
 This performs the two tap process to move the piece.
 - move(_ move: String)
    - move is of form start_location+end_location (ie the first tap location and second tap location)
    - start_location: Start Algebraic Nocation of the board from [a-h][1-8]
    - end_location: End Algebraic Nocation of the board from [a-h][1-8]
*/
move(/*#-editable-code move locations*/"e7e5"/*#-end-editable-code*/)
/*:
# Analyze a move. (You can also click on the "bulb" symbol and get a hint. The hint will highlight the start location and the end location.)
 - bestMove = analyze()
    - This performs an analysis on the chess board with the current player (color)
    - The return value is in the Algebraic form of Algebraic "start_location"+"end_location" which can be used in move() function. 
*/
var bestMove = analyze()
move(bestMove)
/*:
# Color of current player
 - color(_ color: String)
    - color: "w" - White
             "b" - Black
(In general for a game you dont need to set this. After every move, the color is automatically changed. For analysis you can override the color of current player)
 */
color("b")
bestMove = analyze()
//#-editable-code
//#-end-editable-code
