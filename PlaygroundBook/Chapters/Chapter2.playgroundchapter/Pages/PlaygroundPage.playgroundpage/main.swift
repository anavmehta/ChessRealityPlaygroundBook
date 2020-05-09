//: [Previous](@previous)
/*:
 # Play Progammatically
 The functions which are introduced in this page are play(), mode(), sound(), animation(), tap(), move(), analyze(), color()
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
/*:
 - play()
    - This starts or resets the game in the mode it was set to.
*/
play()
/*:
- mode(_ mode: PlayingMode)
   - Sets the playing mode
   - mode: [PlayingMode.SingleDevice,PlayingMode.Computer,PlayingMode.MultiDevice]
   - e.g. mode(.Computer) sets the playing mode with the computer
*/
mode(/*#-editable-code set x*/.SingleDevice/*#-end-editable-code*/)
/*:
- sound(_ enabled: Bool)
   - Toggles sound
   - enabled: [false, true]
   - e.g. sound(false) turns of the animation
*/
sound(/*#-editable-code sound enabled**/true/*#-end-editable-code*/)
/*:

- animation(_ enabled: Bool)
   - Toggle animation
   - enabled: [false, true]
   - e.g. animation(false) turns off the animation
*/
animation(/*#-editable-code animation enabled**/true/*#-end-editable-code*/)
/*:
 - wait()
   - Wait for chessboard to be anchored.
   - If the board is already anchored it returns immediately, or waits for the board to be anchored
*/
wait()
/*:
 - tap(_ position: String)
    - Tap a location on the board
      - On the first tap, if the location has a valid piece is selected and moves are highlighted.
      - On the second tap, the selected piece is moved to a valid new location and piece captured if possible.
    - position: Algebraic location of the board [a-h][1-8]
    - e.g. tap("c2")
*/
tap(/*#-editable-code tap location*/"e2"/*#-end-editable-code*/) //taps and selects pawn at e2
tap(/*#-editable-code tap location*/"e4"/*#-end-editable-code*/) //second tap moves the selected pawn to e4
/*:
 - move(_ move: String)
    - This performs the two tap process to move the piece.
    - move is of form "start_location"+"end_location"
      - start_location: Start Algebraic location of the board [a-h][1-8]
      - end_location: End Algebraic location of the board [a-h][1-8]
    - e.g. move("c2c4")
*/
move(/*#-editable-code move locations*/"e7e5"/*#-end-editable-code*/)
/*:
 - bestMove = analyze()
    - Analyze the board position for best move
      -  This performs an analysis on the chess board with the current player (color)
      -  You can also click on the "bulb" symbol and get a hint.
      -   The hint will highlight the start location and the end location.
    - The return value is in Algebraic notation form "start_location"+"end_location" which can be passed to the move() function.
*/
var bestMove = analyze()
move(bestMove)
/*:
 - color(_ color: String)
    - Override color of current play
    - color: ["w","b"]
    - e.g. color("w")

 (In general, for a game you dont need to set this. After every move, the color is automatically changed. For analysis you can override the color of current player)
 */
color("b")
bestMove = analyze()
//#-editable-code
//#-end-editable-code
