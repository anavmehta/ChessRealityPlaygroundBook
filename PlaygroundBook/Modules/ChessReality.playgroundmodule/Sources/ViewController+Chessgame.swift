//
//  ViewController+Chessgame.swift
//  ChessReality
//
//  Created by Anav Mehta on 3/05/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import RealityKit

extension ViewController {
    
    enum Piece {
        case pawn
        case rook
        case queen
        case king
        case bishop
        case knight
        case empty
    }
    enum Color {
        case black
        case white
    }
    
    func setupBoard() {
        for i in 0...7 {
            for j in 0...7 {
                position[i][j] = ""
            }
        }
        position[0][7] = "wr0"
        position[1][7] = "wn0"
        position[2][7] = "wb0"
        position[3][7] = "wq"
        position[4][7] = "wk"
        position[5][7] = "wb1"
        position[6][7] = "wn1"
        position[7][7] = "wr1"
        position[0][6] = "wp0"
        position[1][6] = "wp1"
        position[2][6] = "wp2"
        position[3][6] = "wp3"
        position[4][6] = "wp4"
        position[5][6] = "wp5"
        position[6][6] = "wp6"
        position[7][6] = "wp7"
        
        position[0][0] = "br0"
        position[1][0] = "bn0"
        position[2][0] = "bb0"
        position[3][0] = "bq"
        position[4][0] = "bk"
        position[5][0] = "bb1"
        position[6][0] = "bn1"
        position[7][0] = "br1"
        position[0][1] = "bp0"
        position[1][1] = "bp1"
        position[2][1] = "bp2"
        position[3][1] = "bp3"
        position[4][1] = "bp4"
        position[5][1] = "bp5"
        position[6][1] = "bp6"
        position[7][1] = "bp7"
        
    }
    
    func pieceType(str: String) -> String {
        let start = str.index(str.startIndex, offsetBy: 1)
        let end = str.index(str.startIndex, offsetBy: 2)
        let range = start..<end
        let subStr = str[range]
        if(subStr == "q") {return "queen"}
        else if(subStr == "k") {return "king"}
        else if(subStr == "p") {return "pawn"}
        else if(subStr == "b") {return "bishop"}
        else if(subStr == "n") {return "knight"}
        else if(subStr == "r") {return "rook"}
        else {return ""}
    }
    

    
    func isOppositeColor(x: Int,y: Int,color:Color) -> Bool {
        let str : String = position[x][y]
        let start = str.index(str.startIndex, offsetBy: 0)
        let end = str.index(str.startIndex, offsetBy: 1)
        let range = start..<end
        let subStr = str[range]
        if((subStr == "w") && (color == .black)) {return(true)}
        if((subStr == "b") && (color == .white)) {return(true)}
        return(false)
    }
    
    
    func isValid(x: Int, y: Int) -> Bool {
        return(x >= 0 && x < 8 && y >= 0 && y < 8)
    }
    func isAvailable(x: Int, y: Int) -> Bool {
        if(position[x][y] == ""){return true}
        return false
    }
    
    func isValidMove(coord: (Int, Int), coords: [(Int, Int)]) -> Bool {
        for c in coords {
            if(coord == c) {
                return(true)
            }
        }
        return(false)
    }
    
    func highlightCommand(coords: [(Int, Int)]) -> String {
        var str: String = "show"
        for c in coords {
            str=str+" \(c.0),\(c.1)"
        }
        return(str)
    }
    func board2position(str:String) -> (Int, Int) {
        var start = str.index(str.startIndex, offsetBy: 3)
        var end = str.index(str.startIndex, offsetBy: 4)
        var range = start..<end
        let i = Int(str[range])!
        start = str.index(str.startIndex, offsetBy: 5)
        end = str.index(str.startIndex, offsetBy: 6)
        range = start..<end
        let j = Int(str[range])!
        return (i,j)
    }
    func board2piece(str:String) -> Entity {
        var start = str.index(str.startIndex, offsetBy: 3)
        var end = str.index(str.startIndex, offsetBy: 4)
        var range = start..<end
        let i = Int(str[range])!
        start = str.index(str.startIndex, offsetBy: 5)
        end = str.index(str.startIndex, offsetBy: 6)
        range = start..<end
        let j = Int(str[range])!
 
        let entity:Entity=game.findEntity(named: position[i][j])!
        return(entity)
    }
    func isBoard(entity: Entity) -> Bool{
        if(isPiece(entity: entity)) {return(false)}
        return(true)
    }
    
    func pieceName(str:String) -> String{
        var start = str.index(str.startIndex, offsetBy: 3)
        var end = str.index(str.startIndex, offsetBy: 4)
        var range = start..<end
        let i = Int(str[range])!
        start = str.index(str.startIndex, offsetBy: 5)
        end = str.index(str.startIndex, offsetBy: 6)
        range = start..<end
        let j = Int(str[range])!
        return(position[i][j])
    }
    
    func isPiece(entity: Entity) -> Bool{
        if(pieceName(str: entity.name) != "") {return(true)}
        else {return(false)}
    }
    
    func entity2color(str: String) -> Color {
        let start = str.index(str.startIndex, offsetBy: 0)
        let end = str.index(str.startIndex, offsetBy: 1)
        let range = start..<end
        let subStr = str[range]
        if(subStr == "w") {return(.white)}
        return(.black)
        
    }
    
    func entity2piece(str: String) -> Piece {
        let start = str.index(str.startIndex, offsetBy: 1)
        let end = str.index(str.startIndex, offsetBy: 2)
        let range = start..<end
        let subStr = str[range]
        if(subStr == "r") {return(.rook)}
        if(subStr == "b") {return(.bishop)}
        if(subStr == "n") {return(.knight)}
        if(subStr == "q") {return(.queen)}
        if(subStr == "k") {return(.king)}
        if(subStr == "p") {return(.pawn)}
        
        return(.empty)
    }
    
    
    func validMoves(x: Int, y: Int) -> [(Int, Int)] {
        let str = position[x][y]
        let piece = entity2piece(str: str)
        let color = entity2color(str: str)
        var retArr: [(Int, Int)] = []
        switch piece {
        case .empty :
            return([])
            
        case .bishop :
            for i in 1...7 {
                if(isValid(x: x+i, y:y+i)) {
                    if(isAvailable(x: x+i, y:y+i)) {
                        retArr.append((x+i, y+i))
                    } else {
                        if(isOppositeColor(x:x+i,y:y+i,color:color)) {
                            retArr.append((x+i,y+i))
                        }
                        break;
                    }
                }
            }
            for i in 1...7 {
                if(isValid(x: x+i, y:y-i)) {
                    if(isAvailable(x: x+i, y:y-i)) {
                        retArr.append((x+i, y-i))
                    } else {
                        if(isOppositeColor(x:x+i,y:y-i,color:color)) {
                            retArr.append((x+i,y-i))
                        }
                        break;
                    }
                }
            }
            for i in 1...7 {
                if(isValid(x: x-i, y:y+i)) {
                    if(isAvailable(x: x-i, y:y+i)) {
                        retArr.append((x-i, y+i))
                    } else {
                        if(isOppositeColor(x:x-i,y:y+i,color:color)) {
                            retArr.append((x-i,y+i))
                        }
                        break;
                    }
                }
            }
            for i in 1...7 {
                if(isValid(x: x-i, y:y-i)) {
                    if(isAvailable(x: x-i, y:y-i)) {
                        retArr.append((x-i, y-i))
                    } else {
                        if(isOppositeColor(x:x-i,y:y-i,color:color)) {
                            retArr.append((x-i,y-i))
                        }
                        break;
                    }
                }
            }
            
        case .queen : // a queen is basically moving like a bishop or a rook
            // bishop
            for i in 1...7 {
                if(isValid(x: x+i, y:y+i)) {
                    if(isAvailable(x: x+i, y:y+i)) {
                        retArr.append((x+i, y+i))
                    } else {
                        if(isOppositeColor(x:x+i,y:y+i,color:color)) {
                            retArr.append((x+i,y+i))
                        }
                        break;
                    }
                }
            }
            for i in 1...7 {
                if(isValid(x: x+i, y:y-i)) {
                    if(isAvailable(x: x+i, y:y-i)) {
                        retArr.append((x+i, y-i))
                    } else {
                        if(isOppositeColor(x:x+i,y:y-i,color:color)) {
                            retArr.append((x+i,y-i))
                        }
                        break;
                    }
                }
            }
            for i in 1...7 {
                if(isValid(x: x-i, y:y+i)) {
                    if(isAvailable(x: x-i, y:y+i)) {
                        retArr.append((x-i, y+i))
                    } else {
                        if(isOppositeColor(x:x-i,y:y+i,color:color)) {
                            retArr.append((x-i,y+i))
                        }
                        break;
                    }
                }
            }
            for i in 1...7 {
                if(isValid(x: x-i, y:y-i)) {
                    if(isAvailable(x: x-i, y:y-i)) {
                        retArr.append((x-i, y-i))
                    } else {
                        if(isOppositeColor(x:x-i,y:y-i,color:color)) {
                            retArr.append((x-i,y-i))
                        }
                        break;
                    }
                }
            }
            // rook
            for i in 1...7 {
                if(isValid(x: x, y:y+i)) {
                    if(isAvailable(x: x, y:y+i)) {
                        retArr.append((x, y+i))
                    } else {
                        if(isOppositeColor(x:x,y:y+i,color:color)) {
                            retArr.append((x,y+i))
                        }
                        break;
                    }
                }
            }
            for i in 1...7 {
                if(isValid(x: x, y:y-i)) {
                    if(isAvailable(x: x, y:y-i)) {
                        retArr.append((x, y-i))
                    } else {
                        if(isOppositeColor(x:x,y:y-i,color:color)) {
                            retArr.append((x,y-i))
                        }
                        break;
                    }
                }
            }
            for i in 1...7 {
                if(isValid(x: x+i, y:y)) {
                    if(isAvailable(x: x+i, y:y)) {
                        retArr.append((x+i, y))
                    } else {
                        if(isOppositeColor(x:x+i,y:y,color:color)) {
                            retArr.append((x+i,y))
                        }
                        break;
                    }
                }
            }
            for i in 1...7 {
                if(isValid(x: x-i, y:y)) {
                    if(isAvailable(x: x-i, y:y)) {
                        retArr.append((x-i, y))
                    } else {
                        if(isOppositeColor(x:x-i,y:y,color:color)) {
                            retArr.append((x-i,y))
                        }
                        break;
                    }
                }
            }
            
        case .king :
            for i in 0...1 {
                for j in 0...1 {
                    if(i == 0 && j == 0) {continue}
                    if(isValid(x:x+i,y:y+j) && isAvailable(x: x+i, y:y+j)) {
                        retArr.append((x+i,y+j))
                    }
                    if(isValid(x:x-i,y:y+j) && isAvailable(x: x-i, y:y+j)) {
                        retArr.append((x-i,y+j))
                    }
                    if(isValid(x:x+i,y:y-j) && isAvailable(x: x+i, y:y-j)) {
                        retArr.append((x+i,y-j))
                    }
                    if(isValid(x:x-i,y:y-j) && isAvailable(x: x-i, y:y-j)) {
                        retArr.append((x-i,y-j))
                    }
                }
            }
        case .rook :
            for i in 1...7 {
                if(isValid(x: x, y:y+i)) {
                    if(isAvailable(x: x, y:y+i)) {
                        retArr.append((x, y+i))
                    } else {
                        if(isOppositeColor(x:x,y:y+i,color:color)) {
                            retArr.append((x,y+i))
                        }
                        break;
                    }
                }
            }
            for i in 1...7 {
                if(isValid(x: x, y:y-i)) {
                    if(isAvailable(x: x, y:y-i)) {
                        retArr.append((x, y-i))
                    } else {
                        if(isOppositeColor(x:x,y:y-i,color:color)) {
                            retArr.append((x,y-i))
                        }
                        break;
                    }
                }
            }
            for i in 1...7 {
                if(isValid(x: x+i, y:y)) {
                    if(isAvailable(x: x+i, y:y)) {
                        retArr.append((x+i, y))
                    } else {
                        if(isOppositeColor(x:x+i,y:y,color:color)) {
                            retArr.append((x+i,y))
                        }
                        break;
                    }
                }
            }
            for i in 1...7 {
                if(isValid(x: x-i, y:y)) {
                    if(isAvailable(x: x-i, y:y)) {
                        retArr.append((x-i, y))
                    } else {
                        if(isOppositeColor(x:x-i,y:y,color:color)) {
                            retArr.append((x-i,y))
                        }
                        break;
                    }
                }
            }
            
        case .knight :
            if(isValid(x: x+1, y:y+2)) {
                if(isAvailable(x: x+1, y:y+2)) {
                    retArr.append((x+1, y+2))
                } else {
                    if(isOppositeColor(x:x+1,y:y+2,color:color)) {
                        retArr.append((x+1,y+2))
                    }
                }
            }
            if(isValid(x: x-1, y:y+2)) {
                if(isAvailable(x: x-1, y:y+2)) {
                    retArr.append((x-1, y+2))
                } else {
                    if(isOppositeColor(x:x-1,y:y+2,color:color)) {
                        retArr.append((x-1,y+2))
                    }
                }
            }
            if(isValid(x: x+1, y:y-2)) {
                if(isAvailable(x: x+1, y:y-2)) {
                    retArr.append((x+1, y-2))
                } else {
                    if(isOppositeColor(x:x+1,y:y-2,color:color)) {
                        retArr.append((x+1,y-2))
                    }
                }
            }
            if(isValid(x: x-1, y:y-2)) {
                if(isAvailable(x: x-1, y:y-2)) {
                    retArr.append((x-1, y-2))
                } else {
                    if(isOppositeColor(x:x-1,y:y-2,color:color)) {
                        retArr.append((x-1,y-2))
                    }
                }
            }
            if(isValid(x: x+2, y:y+1)) {
                if(isAvailable(x: x+2, y:y+1)) {
                    retArr.append((x+2, y+1))
                } else {
                    if(isOppositeColor(x:x+2,y:y+1,color:color)) {
                        retArr.append((x+2,y+1))
                    }
                }
            }
            if(isValid(x: x-2, y:y+1)) {
                if(isAvailable(x: x-2, y:y+1)) {
                    retArr.append((x-2, y+1))
                } else {
                    if(isOppositeColor(x:x-2,y:y+1,color:color)) {
                        retArr.append((x-2,y+1))
                    }
                }
            }
            if(isValid(x: x+2, y:y-1)) {
                if(isAvailable(x: x+2, y:y-1)) {
                    retArr.append((x+2, y-1))
                } else {
                    if(isOppositeColor(x:x+2,y:y-1,color:color)) {
                        retArr.append((x+2,y-1))
                    }
                }
            }
            if(isValid(x: x-2, y:y-1)) {
                if(isAvailable(x: x-2, y:y-1)) {
                    retArr.append((x-2, y-1))
                } else {
                    if(isOppositeColor(x:x-2,y:y-1,color:color)) {
                        retArr.append((x-2,y-1))
                    }
                }
            }
        case .pawn:
            if(color == .white) {
                if(isValid(x: x, y:y-1)) {
                    if(isAvailable(x: x, y:y-1)) {
                        retArr.append((x, y-1))
                    }
                }
                if(y == 6) {
                    if(isValid(x: x, y:y-2)) {
                        if(isAvailable(x:x,y:y-2)) {
                            retArr.append((x, y-2))
                        }
                    }
                }
                if(isValid(x:x+1,y:y-1)) {
                    if(!isAvailable(x:x+1, y:y-1) && isOppositeColor(x:x+1,y:y-1, color:color)) {
                        retArr.append((x+1,y-1))
                        
                    }
                }
                if(isValid(x:x-1,y:y-1)) {
                    if(!isAvailable(x:x-1, y:y-1) && isOppositeColor(x:x-1,y:y-1, color:color)) {
                        retArr.append((x-1,y-1))
                        
                    }
                }
            } else {
                if(isValid(x: x, y:y+1)) {
                    if(isAvailable(x: x, y:y+1)) {
                        retArr.append((x, y+1))
                    }
                }
                if(y == 1) {
                    if(isValid(x: x, y:y+2)) {
                        if(isAvailable(x: x, y:y+2)) {
                            retArr.append((x, y+2))
                        }
                    }
                }
                if(isValid(x:x+1,y:y+1)) {
                    if(!isAvailable(x:x+1, y:y+1) && isOppositeColor(x:x+1,y:y+1, color:color)) {
                        retArr.append((x+1,y+1))
                        
                    }
                }
                if(isValid(x:x-1,y:y+1)) {
                    if(!isAvailable(x:x-1, y:y+1) && isOppositeColor(x:x-1,y:y+1, color:color)) {
                        retArr.append((x-1,y+1))
                    }
                }
            }
        }
        
        return(retArr)
        
    }
    
    func displayValidMoves(x: Int, y: Int) {
        let coords: [(Int, Int)] = validMoves(x: x, y: y)
        for coord in coords {
            let (x, z) = coord
            overlayEntities[x][z].isEnabled = true
            
        }
        
    }
    
    func displayCell(x: Int, y: Int) {
        overlayEntities[x][y].isEnabled = true
    }
    
    func removeCell(x: Int, y: Int) {
        overlayEntities[x][y].isEnabled = false
    }
    

    

    func snapToBoard(x: Float, z: Float) -> (xs: Int, zs:Int) {
        var xs, zs: Int
        xs = Int((x+0.20)/0.05)
        zs = Int((z+0.20)/0.05)
        if(xs < 0){xs = 0}
        if(zs < 0){zs = 0}
        if(xs > 8){xs = 7}
        if(zs > 8){zs = 7}
        return(xs, zs)
    }
    
    func boardCoord(i: Int, j: Int, piece: Piece) -> (x: Float, y: Float, z: Float) {
        var y: Float = 0.0
        if(piece == .pawn) {
            y = 0.025
        } else if(piece == .queen){
            y = 0.05
        } else if(piece == .king) {
            y = 0.06
        } else if(piece == .bishop) {
            y = 0.05
        } else if(piece == .rook) {
            y = 0.03
        } else if(piece == .knight) {
            y = 0.05
        }
        let x: Float = 0.05*Float(i)-0.175
        let z: Float = 0.05*Float(j)-0.175
        return(x,y,z)
    }
    
    func boardToPieceCoords(x: Int, z: Int) -> (xs: Float, zs: Float) {
        var xs, zs: Float
        xs = Float(x)*0.05-0.2
        zs = Float(z)*0.05-0.2
        return(xs, zs)
    }
    // MARK: EngineManagerDelegate
    
    func translateMove(move: String) -> (Int,Int,Int,Int) {
        if((move == "") || (move == "(none)")) {return(-1,-1,-1,-1)}
        let tmpArry = Array(move)
        let scol: Int = Int(tmpArry[0].unicodeScalars.map{$0.value}[0]-"a".unicodeScalars.map{$0.value}[0])
        let srow: Int = Int(tmpArry[1].unicodeScalars.map{$0.value}[0]-"1".unicodeScalars.map{$0.value}[0])
        let ecol: Int = Int(tmpArry[2].unicodeScalars.map{$0.value}[0]-"a".unicodeScalars.map{$0.value}[0])
        let erow: Int = Int(tmpArry[3].unicodeScalars.map{$0.value}[0]-"1".unicodeScalars.map{$0.value}[0])
        //return (srow, scol, erow, ecol)
        return (scol, 7-srow, ecol, 7-erow)
    }
    
    func animate(sx: Int, sy: Int, tx: Int, ty: Int) {
        //if(animationEnabled && !allowMultipeerPlay) {
        if(animationEnabled) {
            let entity: Entity! = self.game.findEntity(named: position[sx][sy])
            //let entity: Entity! = arView.scene.findEntity(named: position[sx][sy])
            let (xt, yt, zt) = boardCoord(i: tx, j: ty, piece:entity2piece(str: position[sx][sy]))
            var translationTransform = entity.transform
            translationTransform.translation = SIMD3<Float>(x:xt,y:yt,z:zt)
            entity.move(to: translationTransform, relativeTo: entity.parent, duration: 1, timingFunction: .easeInOut)
        }
    }
    
    func updateBoard(sx: Int, sy: Int, tx: Int, ty: Int) {
        let pieceName: String = position[sx][sy]

        position[sx][sy] = ""
        if(position[tx][ty] != "") {
            let entity: Entity! = arView.scene.findEntity(named: position[tx][ty])
            //entity.removeFromParent()
            entity.isEnabled = false
            playSound(sound: 2)
        } else {playSound(sound: 1)}
        position[tx][ty] = pieceName
    }
    
    func algebraicNotation(srow: Int, scol: Int, erow: Int, ecol: Int) {
        var s: String = ""
        let spiece: String = position[srow][scol]
        let epiece: String = position[erow][ecol]
        let piece = entity2piece(str: spiece)
        let color = entity2color(str: spiece)
        if(color == .white) {
            numMoves = numMoves + 1
            s = String(numMoves) + "."
        }
        
        if(piece == .king) {s = s + "K"}
        else if(piece == .queen) {s = s + "Q"}
        else if(piece == .knight) {s = s + "N"}
        else if(piece == .rook) {s = s + "R"}
        else if(piece == .bishop) {s = s + "B"}
        if(epiece != "") {s = s + "x"}
        if(piece != .pawn) {s = s + int2string(s:srow)}
        let c:String! = int2string(s: erow)
        s = s + c + String(8-ecol) + " "
        recordString = recordString + s
    }
    
  
    func setupOverlay() {
        
        let cb: Entity! = game.findEntity(named: "cb")
        let box = MeshResource.generateBox(size: [0.05,0.01,0.05]) // Generate mesh
        var material = SimpleMaterial()
        material.baseColor = MaterialColorParameter.color(.init(red: 1.0,
                                                                green: 1.0,
                                                                blue: 0.0,
                                                                alpha: 0.8))
        material.roughness = MaterialScalarParameter(floatLiteral: 0.0)
        material.metallic = MaterialScalarParameter(floatLiteral: 1.0)
        
        
        for i in 0...7 {
            for j in 0...7 {
                overlayEntities[i][j] = ModelEntity(mesh: box, materials: [material])
                cb.addChild(overlayEntities[i][j])
                let (x, _, z) = boardCoord(i: i, j: j, piece:.empty)
                overlayEntities[i][j].setPosition([x, 0.001, z], relativeTo: cb)
                overlayEntities[i][j].isEnabled = false
            }
        }
    }
    
    func removeOverlay() {
        for i in 0...7 {
            for j in 0...7 {
                overlayEntities[i][j].isEnabled = false
            }
        }
    }

    func setPiece(pieceName: String, tx: Int, ty: Int) {
        let piece: Entity! = game.findEntity(named: pieceName)
        let (x, y, z) = boardCoord(i: tx, j: ty, piece:entity2piece(str: pieceName))
        piece.setPosition([x, y, z], relativeTo: game)
    }
    func movePiece(sx: Int, sy: Int, tx: Int, ty: Int){
        let pieceName = position[sx][sy]
        let piece: Entity! = arView.scene.findEntity(named: pieceName)
        let (x, y, z) = boardCoord(i: tx, j: ty, piece:entity2piece(str: pieceName))
        animate(sx: sx, sy: sy, tx: tx, ty: ty)
        piece.setPosition([x, y, z], relativeTo: game)
        algebraicNotation(srow: sx, scol: sy, erow: tx, ecol: ty)
        updateBoard(sx: sx, sy: sy, tx: tx, ty: ty)
        removeOverlay()
        displayCell(x: tx, y: ty)
    }
    func displayMove() {

        //let (sx, sy, tx, ty) = translateMove(move: bestMoveNext)
        let (sx, sy, tx, ty) = (startPosXY.0, startPosXY.1, endPosXY.0, endPosXY.1)
        movePiece(sx: sx, sy: sy, tx: tx, ty: ty)
        bestMoveNext = ""
    }
    

    
    func setupChessBoard() {
        var chessBoxes: [[ModelEntity]] = Array<[ModelEntity]>(repeating: Array<ModelEntity>(repeating: ModelEntity(), count: 8), count:8)
        var wp: [Entity] =  Array<Entity>(repeating: Entity(), count: 8)
        var bp: [Entity] =  Array<Entity>(repeating: Entity(), count: 8)
        var x: Float!
        var y: Float!
        var z: Float!
        let collisionComp = CollisionComponent(
            shapes: [.generateBox(size: [0.055,0.001,0.055])],
            mode: .trigger,
            filter: .sensor
        )

        var white_material = SimpleMaterial()
        white_material.baseColor = MaterialColorParameter.color(.init(red: 1.0,
                                                                      green: 1.0,
                                                                      blue: 1.0,
                                                                      alpha: 1.0))
        white_material.roughness = MaterialScalarParameter(floatLiteral: 0.0)
        white_material.metallic = MaterialScalarParameter(floatLiteral: 0.0)
        
        var black_material = SimpleMaterial()
        black_material.baseColor = MaterialColorParameter.color(.init(red: 0.0,
                                                                      green: 0.0,
                                                                      blue: 0.0,
                                                                      alpha: 1.0))
        black_material.roughness = MaterialScalarParameter(floatLiteral: 0.0)
        black_material.metallic = MaterialScalarParameter(floatLiteral: 0.0)
        
        var green_material = SimpleMaterial()
        green_material.baseColor = MaterialColorParameter.color(.init(red: 0.0,
                                                                      green: 0.5,
                                                                      blue: 0.0,
                                                                      alpha: 1.0))
        green_material.roughness = MaterialScalarParameter(floatLiteral: 0.0)
        green_material.metallic = MaterialScalarParameter(floatLiteral: 0.0)
        
        let red_material = SimpleMaterial(color: .red, isMetallic: false)
        game = Entity()
        game.name = "game"
        game.synchronization = nil
        
        
        var material: SimpleMaterial!
        let cb = Entity()
        cb.name = "cb"
        game.addChild(cb)
 
        
        var box = MeshResource.generateBox(size: [0.5,0,0.5]) // Generate mesh
        let leftBox = ModelEntity(mesh: box, materials: [white_material])
        cb.addChild(leftBox)
        (x, y, z) = boardCoord(i: 3, j: 3 , piece:.empty)
        leftBox.setPosition([x+0.025, -0.001, z+0.025], relativeTo: cb)
        
        for i in 0...7 {
            let mesh = MeshResource.generateText(
                String(8-i),
                extrusionDepth: 0.025,
                font: .systemFont(ofSize: 2),
                containerFrame: .zero,
                alignment: .center,
                lineBreakMode: .byTruncatingTail)
        

            let textEntity = ModelEntity(mesh: mesh, materials: [red_material])
            textEntity.scale = SIMD3<Float>(0.0125, 0.0125, 0.0125)
        
            leftBox.addChild(textEntity)
            x = -0.175-0.05
            z = 0.05*Float(i)-0.175
            textEntity.setPosition([x, 0.001, z], relativeTo: cb)
        }
        let startingValue = Int(("a" as UnicodeScalar).value)
        for i in 0...7 {
            let mesh = MeshResource.generateText(
                String(UnicodeScalar(i + startingValue)!),
                extrusionDepth: 0.025,
                font: .systemFont(ofSize: 2),
                containerFrame: .zero,
                alignment: .center,
                lineBreakMode: .byTruncatingTail)
        

            let textEntity = ModelEntity(mesh: mesh, materials: [red_material])
            textEntity.scale = SIMD3<Float>(0.0125, 0.0125, 0.0125)
        
            leftBox.addChild(textEntity)
            z = 0.05*8-0.175
            x = 0.05*Float(i)-0.175
            textEntity.setPosition([x, 0.001, z], relativeTo: cb)
        }
        
        
        box = MeshResource.generateBox(size: [0.05,0.01,0.05]) // Generate mesh
        let url = Bundle.main.url(forResource: "chess_pieces", withExtension: "usdz")!
        
        let pieces: Entity = try! Entity.load(contentsOf: url)
        
        for i in 0...7 {
            for j in 0...7 {
                if((i+j) % 2 == 0) {material = white_material}
                else {material = green_material}
                chessBoxes[i][j] = ModelEntity(mesh: box, materials: [material])
                chessBoxes[i][j].name = "cb_"+String(i)+"_"+String(j)
                cb.addChild(chessBoxes[i][j])
                (x, _, z) = boardCoord(i: i, j: j, piece: .empty)
                chessBoxes[i][j].components.set(collisionComp)
                chessBoxes[i][j].setPosition([x, 0.0, z], relativeTo: cb)
                chessBoxes[i][j].isEnabled = true
            }
        }
        
        let pawn: Entity = pieces.findEntity(named: "Pawn_Cylinder")!
        let wpEntity: Entity = pawn.clone(recursive: true)
        var modelComp: ModelComponent = (wpEntity.components[ModelComponent])!
        modelComp.materials[0] = white_material
        wpEntity.components.set(modelComp)
        
        for i in 0...7 {
            wp[i] = wpEntity.clone(recursive: true)
            wp[i].name = "wp"+String(i)
            (x, y, z) = boardCoord(i: i, j: 6, piece:.pawn)
            wp[i].setPosition([x, y, z], relativeTo: cb)
            game.addChild(wp[i])
        }
        
        let bpEntity: Entity = pawn.clone(recursive: true)
        modelComp = (bpEntity.components[ModelComponent])!
        modelComp.materials[0] = black_material
        bpEntity.components.set(modelComp)
        for i in 0...7 {
            bp[i] = bpEntity.clone(recursive: true)
            bp[i].name = "bp"+String(i)
            (x, y, z) = boardCoord(i: i, j: 1, piece:.pawn)
            bp[i].setPosition([x, y, z], relativeTo: cb)
            game.addChild(bp[i])
        }
        
        
        let king: Entity = pieces.findEntity(named: "King_Cylinder_004")!
        let wk: Entity = king.clone(recursive: true)
        wk.name = "wk"
        modelComp = (wk.components[ModelComponent])!
        modelComp.materials[0] = white_material
        wk.components.set(modelComp)
        (x, y, z) = boardCoord(i: 4, j: 7, piece:.king)
        wk.setPosition([x, y, z], relativeTo: cb)
        game.addChild(wk)
        
        let bk: Entity = king.clone(recursive: true)
        bk.name = "bk"
        modelComp = (bk.components[ModelComponent])!
        modelComp.materials[0] = black_material
        bk.components.set(modelComp)
        //bk.components.set(collisionComp)
        (x, y, z) = boardCoord(i: 4, j: 0, piece:.king)
        bk.setPosition([x, y, z], relativeTo: cb)
        game.addChild(bk)
        
        let bishop: Entity = pieces.findEntity(named: "Bishop_Cylinder_003")!
        let wb0: Entity = bishop.clone(recursive: true)
        wb0.name = "wb0"
        modelComp = (wb0.components[ModelComponent])!
        modelComp.materials[0] = white_material
        wb0.components.set(modelComp)
        //wb0.components.set(collisionComp)
        (x, y, z) = boardCoord(i: 2, j: 7, piece:.bishop)
        wb0.setPosition([x, y, z], relativeTo: game)
        game.addChild(wb0)
        
        
        let wb1: Entity = bishop.clone(recursive: true)
        wb1.name = "wb1"
        modelComp = (wb1.components[ModelComponent])!
        modelComp.materials[0] = white_material
        wb1.components.set(modelComp)
        //wb1.components.set(collisionComp)
        (x, y, z) = boardCoord(i: 5, j: 7, piece:.bishop)
        wb1.setPosition([x, y, z], relativeTo: game)
        game.addChild(wb1)
        
        let bb0: Entity = bishop.clone(recursive: true)
        bb0.name = "bb0"
        modelComp = (bb0.components[ModelComponent])!
        
        modelComp.materials[0] = black_material
        bb0.components.set(modelComp)
        (x, y, z) = boardCoord(i: 2, j: 0, piece:.bishop)
        bb0.setPosition([x, y, z], relativeTo: cb)
        game.addChild(bb0)
        
        let bb1: Entity = bishop.clone(recursive: true)
        bb1.name = "bb1"
        modelComp = (bb1.components[ModelComponent])!
        modelComp.materials[0] = black_material
        bb1.components.set(modelComp)
        (x, y, z) = boardCoord(i: 5, j: 0, piece:.bishop)
        bb1.setPosition([x, y, z], relativeTo: game)
        game.addChild(bb1)
        
        let rook: Entity = pieces.findEntity(named: "Rook_Cylinder_001")!
        let wr0: Entity = rook.clone(recursive: true)
        wr0.name = "wr0"
        modelComp = (wr0.components[ModelComponent])!
        
        modelComp.materials[0] = white_material
        wr0.components.set(modelComp)
        (x, y, z) = boardCoord(i: 0, j: 7, piece:.rook)
        wr0.setPosition([x, y, z], relativeTo: cb)
        game.addChild(wr0)
        
        
        let wr1: Entity = rook.clone(recursive: true)
        wr1.name = "wr1"
        modelComp = (wr1.components[ModelComponent])!
        modelComp.materials[0] = white_material
        wr1.components.set(modelComp)
        (x, y, z) = boardCoord(i: 7, j: 7, piece:.rook)
        wr1.setPosition([x, y, z], relativeTo: cb)
        game.addChild(wr1)
        
        let br0: Entity = rook.clone(recursive: true)
        br0.name = "br0"
        modelComp = (br0.components[ModelComponent])!
        modelComp.materials[0] = black_material
        br0.components.set(modelComp)
        (x, y, z) = boardCoord(i: 0, j: 0, piece:.rook)
        br0.setPosition([x, y, z], relativeTo: cb)
        game.addChild(br0)
        
        let br1: Entity = rook.clone(recursive: true)
        br1.name = "br1"
        modelComp = (br1.components[ModelComponent])!
        modelComp.materials[0] = black_material
        br1.components.set(modelComp)
        (x, y, z) = boardCoord(i: 7, j: 0, piece:.rook)
        br1.setPosition([x, y, z], relativeTo: cb)
        game.addChild(br1)
        
        
        let queen: Entity = pieces.findEntity(named: "Queen_Cylinder_002")!
        let wq: Entity = queen.clone(recursive: true)
        wq.name = "wq"
        modelComp = (wq.components[ModelComponent])!
        modelComp.materials[0] = white_material
        wq.components.set(modelComp)
        (x, y, z) = boardCoord(i: 3, j: 7, piece:.queen)
        wq.setPosition([x, y, z], relativeTo: cb)
        game.addChild(wq)
        
        let bq: Entity = queen.clone(recursive: true)
        bq.name = "bq"
        modelComp = (bq.components[ModelComponent])!
        modelComp.materials[0] = black_material
        bq.components.set(modelComp)
        (x, y, z) = boardCoord(i: 3, j: 0, piece:.queen)
        bq.setPosition([x, y, z], relativeTo: cb)
        game.addChild(bq)
        
        let knight: Entity = pieces.findEntity(named: "Cylinder_Cylinder_005")!
        knight.name = "knight"
        let wn0: Entity = knight.clone(recursive: true)
        wn0.name = "wn0"
        modelComp = (wn0.components[ModelComponent])!
        modelComp.materials[0] = white_material
        wn0.components.set(modelComp)
        (x, y, z) = boardCoord(i: 1, j: 7, piece:.knight)
        wn0.setPosition([x, y, z], relativeTo: cb)
        game.addChild(wn0)
        
        let wn1: Entity = knight.clone(recursive: true)
        wn1.name = "wn1"
        modelComp = (wn1.components[ModelComponent])!
        modelComp.materials[0] = white_material
        wn1.components.set(modelComp)
        (x, y, z) = boardCoord(i: 6, j: 7, piece:.knight)
        wn1.setPosition([x, y, z], relativeTo: cb)
        game.addChild(wn1)
        
        let bn0: Entity = knight.clone(recursive: true)
        bn0.name = "bn0"
        modelComp = (bn0.components[ModelComponent])!
        
        modelComp.materials[0] = black_material
        bn0.components.set(modelComp)
        (x, y, z) = boardCoord(i: 1, j: 0, piece:.knight)
        bn0.setPosition([x, y, z], relativeTo: cb)
        game.addChild(bn0)
        
        let bn1: Entity = knight.clone(recursive: true)
        bn1.name = "bn1"
        modelComp = (bn1.components[ModelComponent])!
        modelComp.materials[0] = black_material
        bn1.components.set(modelComp)
        //bn1.components.set(collisionComp)
        (x, y, z) = boardCoord(i: 6, j: 0, piece:.knight)
        bn1.setPosition([x, y, z], relativeTo: cb)
        game.addChild(bn1)

        setupOverlay()
        setupBoard()
        placedBoard = true
        
    }
    
    func resetBoard() {
        var piece: Entity
        var name: String
        var x: Float!
        var y: Float!
        var z: Float!
        if(!placedBoard) {return}
        setupBoard()
        removeOverlay()
        let cb: Entity=game.findEntity(named:"cb")!
        for i in 0...7 {
            name = "wp"+String(i)
            piece = game.findEntity(named: name)!
            (x, y, z) = boardCoord(i: i, j: 6, piece:.pawn)
            piece.setPosition([x, y, z], relativeTo: cb)
            piece.isEnabled=true
        }

        for i in 0...7 {
            name = "bp"+String(i)
            piece = game.findEntity(named: name)!
            (x, y, z) = boardCoord(i: i, j: 1, piece:.pawn)
            piece.setPosition([x, y, z], relativeTo: cb)
            piece.isEnabled = true
        }
        
        
        name = "wk"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 4, j: 7, piece:.king)
        piece.setPosition([x, y, z], relativeTo: cb)
        piece.isEnabled = true
        
        name = "bk"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 4, j: 0, piece:.king)
        piece.setPosition([x, y, z], relativeTo: cb)
        piece.isEnabled = true


        name = "wb0"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 2, j: 7, piece:.bishop)
        piece.setPosition([x, y, z], relativeTo: game)
        piece.isEnabled = true
        

        name = "wb1"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 5, j: 7, piece:.bishop)
        piece.setPosition([x, y, z], relativeTo: game)
        piece.isEnabled = true

        name = "bb0"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 2, j: 0, piece:.bishop)
        piece.setPosition([x, y, z], relativeTo: cb)
        piece.isEnabled = true
        

        name = "bb1"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 5, j: 0, piece:.bishop)
        piece.setPosition([x, y, z], relativeTo: game)
        piece.isEnabled = true
        

        name = "wr0"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 0, j: 7, piece:.rook)
        piece.setPosition([x, y, z], relativeTo: cb)
        piece.isEnabled = true
        

        name = "wr1"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 7, j: 7, piece:.rook)
        piece.setPosition([x, y, z], relativeTo: cb)
        piece.isEnabled = true
        

        name = "br0"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 0, j: 0, piece:.rook)
        piece.setPosition([x, y, z], relativeTo: cb)
        piece.isEnabled = true
        

        name = "br1"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 7, j: 0, piece:.rook)
        piece.setPosition([x, y, z], relativeTo: cb)
        piece.isEnabled = true
        
        

        name = "wq"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 3, j: 7, piece:.queen)
        piece.setPosition([x, y, z], relativeTo: cb)
        piece.isEnabled = true
        

        name = "bq"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 3, j: 0, piece:.queen)
        piece.setPosition([x, y, z], relativeTo: cb)
        piece.isEnabled = true
        

        name = "wn0"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 1, j: 7, piece:.knight)
        piece.setPosition([x, y, z], relativeTo: cb)
        piece.isEnabled = true
        

        name = "wn1"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 6, j: 7, piece:.knight)
        piece.setPosition([x, y, z], relativeTo: cb)
        piece.isEnabled = true
        
        name = "bn0"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 1, j: 0, piece:.knight)
        piece.setPosition([x, y, z], relativeTo: cb)
        piece.isEnabled = true
        

        name = "bn1"
        piece = game.findEntity(named: name)!
        (x, y, z) = boardCoord(i: 6, j: 0, piece:.knight)
        piece.setPosition([x, y, z], relativeTo: cb)
        piece.isEnabled = true

        
    }
      
      
    
    func get_fen(arr: [[String]]) -> String {
        var fen: String = ""
        var fen_row: String = ""
        var prev_blanks: Int = 0
        var sq: String
        
        //for row in (0...7).reversed() {
        for row in 0...7 {
            fen_row = ""
            prev_blanks = 0
            for col in 0...7 {
                sq = arr[col][row]
                if (sq == "empty" || sq == "" || sq == " ") {
                    prev_blanks = prev_blanks+1
                    if(col == 7) {
                        fen_row += String(prev_blanks)
                        prev_blanks = 0
                    }
                } else {
                    if(prev_blanks != 0) {fen_row += String(prev_blanks)}
                    prev_blanks = 0
                    let start = sq.index(sq.startIndex, offsetBy: 1)
                    let end = sq.index(sq.startIndex, offsetBy: 2)
                    if(sq.prefix(1) == "b") {
                        fen_row += sq[start..<end]
                    } else {
                        fen_row += sq[start..<end].uppercased()
                    }
                }
            }
            if(7 > row) {fen_row = fen_row + "/"}
            fen = fen + fen_row
        }
        return fen
    }
    
    
    func tap(str: String) -> Bool{
        if(!planeAnchorAdded) {return(false)}
        var start = str.index(str.startIndex, offsetBy: 0)
        var end = str.index(str.startIndex, offsetBy: 1)
        var range = start..<end
        var val:String = String(str[range])
        let x = string2int(s: val)
        start = str.index(str.startIndex, offsetBy: 1)
        end = str.index(str.startIndex, offsetBy: 2)
        range = start..<end
        val = String(str[range])
        let y = 8-Int(val)!

        if(selectedPiece == nil) {
            if(position[x][y] == "") {return(false)}
            selectedPiece = game.findEntity(named: position[x][y])
            moves = validMoves(x: x, y: y)
            if (moves.count == 0) {
                alertController.message = selectedPiece.name + " selected piece cannot be moved"
                self.present(alertController, animated: true, completion: nil)
                selectedPiece = nil
                return(false)
            }
            removeOverlay()
            displayValidMoves(x: x, y: y)
            startPosXY = (x, y)
        } else {
            if(!isValidMove(coord: (x, y), coords: moves)) {
                return(false)
            }
            endPosXY = (x, y)
            movePiece(sx: startPosXY.0, sy: startPosXY.1, tx: endPosXY.0, ty: endPosXY.1)
        }
        return(true)
    }
    
    func move(sx: Int, sy: Int, tx: Int, ty: Int) -> Bool{
        
        if(position[sx][sy] == "") {return (false)}
        let moves = validMoves(x: sx, y: sy)
        if (moves.count == 0) {
            return (false)
        }
        removeOverlay()
        displayValidMoves(x: sx, y: sy)
        if(!isValidMove(coord: (tx, ty), coords: moves)) {
            return (false)
        }
        movePiece(sx: sx, sy: sy, tx: tx, ty: ty)
        return(true)
    }
    
    func move(str: String) -> Bool {
        if(!planeAnchorAdded) {return(false)}
        var start = str.index(str.startIndex, offsetBy: 0)
        var end = str.index(str.startIndex, offsetBy: 1)
        var range = start..<end
        var val:String = String(str[range])
        let sx:Int = string2int(s: val)
        start = str.index(str.startIndex, offsetBy: 1)
        end = str.index(str.startIndex, offsetBy: 2)
        range = start..<end
        val = String(str[range])
        let sy:Int = 8-Int(val)!
        
        start = str.index(str.startIndex, offsetBy: 2)
        end = str.index(str.startIndex, offsetBy: 3)
        range = start..<end
        val = String(str[range])
        let tx:Int = string2int(s: val)
        
        start = str.index(str.startIndex, offsetBy: 3)
        end = str.index(str.startIndex, offsetBy: 4)
        range = start..<end
        val = String(str[range])
        let ty:Int = 8-Int(val)!

        if(position[sx][sy] == "") {return (false)}
        let moves = validMoves(x: sx, y: sy)
        if (moves.count == 0) {
            return (false)
        }
        removeOverlay()
        displayValidMoves(x: sx, y: sy)
        if(!isValidMove(coord: (tx, ty), coords: moves)) {
            return (false)
        }
        movePiece(sx: sx, sy: sy, tx: tx, ty: ty)
        return(true)

        
    }
    
    func interpretCommand(str: String) {
        var sx: Int!
        var sy: Int!
        var tx: Int!
        var ty: Int!
        var start = str.index(str.startIndex, offsetBy: 0)
        var end = str.index(str.startIndex, offsetBy: 4)
        var range = start..<end
        let command = str[range]
        switch command {
        case "move":
            start = str.index(str.startIndex, offsetBy: 5)
            end = str.index(str.startIndex, offsetBy: 6)
            range = start..<end
            sx = Int(str[range])!
            start = str.index(str.startIndex, offsetBy: 7)
            end = str.index(str.startIndex, offsetBy: 8)
            range = start..<end
            sy = Int(str[range])!
            start = str.index(str.startIndex, offsetBy: 9)
            end = str.index(str.startIndex, offsetBy: 10)
            range = start..<end
            tx = Int(str[range])!
            start = str.index(str.startIndex, offsetBy: 11)
            end = str.index(str.startIndex, offsetBy: 12)
            range = start..<end
            ty = Int(str[range])!
            movePiece(sx: sx, sy: sy, tx: tx, ty: ty)


        case "show":
            var i:Int = 5
            while(i < str.count) {
                start = str.index(str.startIndex, offsetBy: i)
                end = str.index(str.startIndex, offsetBy: i+1)
                range = start..<end
                sx = Int(str[range])!
                start = str.index(str.startIndex, offsetBy: i+2)
                end = str.index(str.startIndex, offsetBy: i+3)
                range = start..<end
                sy = Int(str[range])!
                displayCell(x: sx, y: sy)
                i = i + 4
            }
        default:
            _=0
        }
    }
    
    func clearBoard() {
        var piece: Entity
        for i in 0...7 {
            for j in 0...7 {
                if(position[i][j] != "") {
                    piece = self.game.findEntity(named: position[i][j])!
                    piece.isEnabled = false
                }
                position[i][j] = ""
            }
        }
    }
    func enableBoard() {
        var piece: Entity
        for i in 0...7 {
            for j in 0...7 {
                if(position[i][j] != "") {
                    piece = self.game.findEntity(named: position[i][j])!
                    piece.isEnabled = true
                    setPiece(pieceName: position[i][j], tx: i, ty: j)
                }
            }
        }
    }
    public func setBoard() {
        if(boardType == 1) {
            soundEnabled = false
            clearBoard()
            curColor = "b"
            //6k1/pp4p1/2p5/2bp4/8/P5Pb/1P3rrP/2BRRN1K b - - 0 1
            position[6][0] = "bk"
            position[0][1] = "bp0"
            position[1][1] = "bp1"
            position[6][1] = "bp2"
            position[2][2] = "bp3"
            position[2][3] = "bb0"
            position[3][3] = "bp4"
            position[0][5] = "wp0"
            position[6][5] = "wp1"
            position[7][5] = "bb1"
            position[1][6] = "wp2"
            position[5][6] = "br0"
            position[6][6] = "br1"
            position[7][6] = "wp3"
            position[2][7] = "wb0"
            position[3][7] = "wr0"
            position[4][7] = "wr1"
            position[5][7] = "wn0"
            position[7][7] = "wk"
            enableBoard()
            

        }
        if(boardType == 2) {
            soundEnabled = false
            clearBoard()
            curColor = "b"
            //8/2k2p2/2b3p1/P1p1Np2/1p3b2/1P1K4/5r2/R3R3 b
            position[3][1] = "bk"
            position[5][1] = "bp0"
            position[2][2] = "bb0"
            position[6][2] = "bp1"
            position[0][3] = "wp0"
            position[2][3] = "bp2"
            position[4][3] = "wn0"
            position[5][3] = "bp3"
            position[1][4] = "bp4"
            position[5][4] = "bb1"
            position[1][5] = "wp1"
            position[3][5] = "wk"
            position[5][6] = "br0"
            position[0][7] = "wr0"
            position[4][7] = "wr1"
            enableBoard()
            

        }
        
    }
}
