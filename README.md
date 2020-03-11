# ChessRealityPlaygroundBook

ChessReality is a unique rendention of the Augmented Reality chess using RealityKit. A tap places the chessboard and pieces on a horizontal surface and can be played with a single device, or with a computer using an open source engine SwitftChess , or with another user using his or her own device using Multipeer Synchronization framework.  It uses Playgroundbook as chapters and pages and introduces features in each chapter via a cutscene. Attributions chess obj models, sounds and images assets and chess engine used are described in detail in the Comments section..

The following are features available in the live view

   On the menu bar from left to right, the three available modes, “Single device”, “Play with computer” and “Play with another player”. Below the menu options is a label view for tell the user the current state of the game and below it is an information label which provides status and updates during the game.

   A 8x8 board which be placed on a 20cmx20cm horizontal surface. The piece can be moved in a two step process. The first tap selects the piece and highlights the possible moves available by the piece. The second tap places the piece.
The three modes are :
“Single device”: A single device used to play both white and black.
“Play with computer”: The play alternates between the user and computer
“Play with another device”: Devices connect in peer mode. Then one player places the board and starts the play. The play information is exchanged using multipeer messages and the Augmented Reality overlay is updated.

The following features are available in the playground.

   Ch1 features the live view which can be played on the live view with a single device in Swift Playground.

   Ch2 introduces functions tap, move, analyze used to manipulate the live view from the playground.
 
   Ch3 you can do the same functions of Ch1 and Ch2 but using computer as your opponent.

   Ch4 plays with another person/device using the Multipeer Connectivity framework.

In this app, a novel constraint solver and RealityKit, UIKit, and AVKit features were implemented.

   Integration of various technogies to create a Augmented Reality game to be used in various modes. Integration with 3rd party Chess Engine (SwiftChess) and Multipeer communication between devices to communicate state of the play

   UIView and ViewController 
   
        Arranging views using constraints labels buttons, and call backs

   Asynchronous Playground Communication with Live View
   
        Six functions can be used in the playground. The parameters are packaged into strings and unpackaged in live view and command executed, and in case of a expected response, a value is sent back to the playground.  

   RealityKit
   
        The ChessBoard is created programmatically using Meshmodels. For the chess pieces, an.free obj was downloaded from CGTrader. This was converted using RealityConverter to .usdz.

   Chess Engine
   
        SwiftChess engine was used from https://github.com/SteveBarnegren/SwiftChess under the MIT license

   Hype Tumult to a cutscene with a video showcasing each chapter.

   Markup in playground

   AVKit for sounds for various events (hints, loss, win,..). 
