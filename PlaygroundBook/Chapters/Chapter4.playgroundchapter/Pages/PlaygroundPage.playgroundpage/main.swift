//: [Previous](@previous)
/*:
 # Play with Another Device
 - Play with opponent with another device using the same playgroundbook or the companion ChessReality app on the appstore.
 - Press **Run My Code** and use **landscape** for best experience.
 - Pair with another device on your WiFi network - your id and your peerid will turn green when you pair. It may take between 30sec-1min for the pairing to take place.
 - Move your camera before tapping for board placement for better detection of horizontal feature points.
 - The first one who places the board plays white.
 - If you need a hint use the **yellow bulb** button.
 Enjoy! 😊
 */
//#-hidden-code
import PlaygroundSupport
import Foundation
import ChessReality
PlaygroundListener.shared.setup()
//#-end-hidden-code
mode(.MultiDevice)
wait_for_anchor()
//#-editable-code
// You can write your own code with analyze() and move() to play against your opponent
//#-end-editable-code
