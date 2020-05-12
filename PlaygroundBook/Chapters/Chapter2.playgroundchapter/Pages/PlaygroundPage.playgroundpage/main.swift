//: [Previous](@previous)
/*:
 # Play Progammatically in Playground
 - Introduces in detail play(), mode(), sound(), animation(), tap(), move(), analyze(), color()
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
   - mode: [.SingleDevice,.Computer,.MultiDevice]
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
   - If the board is already anchored it returns immediately, else it waits for the board to be anchored
*/
wait()
/*:
 - tap(_ position: String)
    - Tap a location on the board
      - On first tap, a valid piece is selected and legal moves are highlighted.
      - On second tap, the selected piece is moved to a valid location and piece captured if possible.
    - position: Algebraic location [a-h][1-8]
    - e.g. tap("c2")
*/
tap(/*#-editable-code tap location*/"e2"/*#-end-editable-code*/) //taps and selects pawn at e2
tap(/*#-editable-code tap location*/"e4"/*#-end-editable-code*/) //second tap moves the selected pawn to e4
/*:
 - move(_ move: String)
    - This performs the two tap process to move the piece.
    - move: Algebraic notation "start_location"+"end_location"
      - start_location: Start Algebraic location [a-h][1-8]
      - end_location: End Algebraic location [a-h][1-8]
    - e.g. move("c2c4")
*/
move(/*#-editable-code move locations*/"e7e5"/*#-end-editable-code*/)
/*:
 - bestMove = analyze()
    - Analyzes the board position of the current player (color) and highlights the start and end location of the best move
    - bestMove: Algebraic notation "start_location"+"end_location" (can be used in the move() function).
    - Use the **bulb** button to perform the analysis in liveview and get a hint.
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
