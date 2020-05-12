/*:
 # ChessReality Simple Playground
 - Introduces mode(), sound(), animation() and wait()
 - Remember:
    - Press **Run My Code** and use **landscape** for best experience.
    - Move your camera before tapping for board placement for better detection of horizontal feature points.
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
mode(.SingleDevice)
sound(/*#-editable-code sound enabled*/true/*#-end-editable-code*/)
animation(/*#-editable-code animation enabled*/true/*#-end-editable-code*/)
wait()
