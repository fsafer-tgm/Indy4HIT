//
//  GameScene.swift
//  Indy4HIT
//
//  Created by Florian Safer on 29.01.20.
//  Copyright © 2020 Florian Safer. All rights reserved.
//

import SpriteKit
import GameplayKit

struct modeStruct {
    static let easy = 0
    static let medium = 1
    static let hard = 2
}


class GameScene: SKScene {
    let indy = SKSpriteNode(imageNamed: "Indy")
    var wiese = SKSpriteNode()
    var gamemode = -1
    var field = [[SKSpriteNode]]()
    var knochenX = -1
    var knochenY = -1
    let speicher = UserDefaults.standard
    
    init(size: CGSize ,selected: Int) {
        super.init(size: size)
        /**
         Wäre mit Switch Case sinnvoller oder?
         */
        if selected == 0 {
            gamemode = modeStruct.easy
        } else if selected == 1 {
            gamemode = modeStruct.medium
        } else if selected == 2 {
            gamemode = modeStruct.hard
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        wiese = SKSpriteNode(color: SKColor(displayP3Red: 34/255, green: 139/255, blue: 34/255, alpha: 1), size: CGSize(width: self.size.width, height: self.size.height))
        wiese.position = CGPoint(x: wiese.size.width/2, y: wiese.size.height/2)
        indy.position = CGPoint(x: 0, y: 0)
        if self.gamemode == modeStruct.easy{
            indy.size = CGSize(width: self.size.height/3-50, height: self.size.height/3-50)
        }else if self.gamemode == modeStruct.medium{
            indy.size = CGSize(width: self.size.height/5-30, height: self.size.height/5-30)
        }else if self.gamemode == modeStruct.hard{
            indy.size = CGSize(width: self.size.height/7-10, height: self.size.height/7-10)
        }
        
        self.addChild(wiese)
        self.addChild(indy)
        
        zeichneRaster()

        if gamemode == modeStruct.easy{
            field = Array<Array>(repeating: Array<SKSpriteNode>(repeating: SKSpriteNode(), count: 3), count: 3)
        }else if gamemode == modeStruct.medium{
            field = Array<Array>(repeating: Array<SKSpriteNode>(repeating: SKSpriteNode(), count: 5), count: 5)
        }else if gamemode == modeStruct.hard{
            field = Array<Array>(repeating: Array<SKSpriteNode>(repeating: SKSpriteNode(), count: 7), count: 7)
        }
        
        setKnochen()
        
    }
    
    func zeichneRaster(){
        if gamemode == modeStruct.easy{
            if let grid = Grid(width: self.size.width/3, height: self.size.height/3, rows: 3, cols: 3) {
                grid.position = CGPoint (x:frame.midX, y:frame.midY)
                addChild(grid)
            }
        }else if gamemode == modeStruct.medium{
            if let grid = Grid(width: self.size.width/5, height: self.size.height/5, rows: 5, cols: 5) {
                grid.position = CGPoint (x:frame.midX, y:frame.midY)
                addChild(grid)
                
                
            }
        }else if gamemode == modeStruct.hard{
            if let grid = Grid(width: self.size.width/7, height: self.size.height/7, rows: 7, cols: 7) {
                grid.position = CGPoint (x:frame.midX, y:frame.midY)
                addChild(grid)
                
                
            }
        }
            
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touches = touches.first
        let touchLocation = touches?.location(in: self)
        
        var tmpX = 0
        var tmpY = 0
        if gamemode == modeStruct.easy{
            tmpX = Int(wiese.size.width/3)
            tmpY = Int(wiese.size.height/3)
        }else if gamemode == modeStruct.medium{
            tmpX = Int(wiese.size.width/5)
            tmpY = Int(wiese.size.height/5)
        }else if gamemode == modeStruct.hard{
            tmpX = Int(wiese.size.width/7)
            tmpY = Int(wiese.size.height/7)
        }
            
            
            
        let barrierLeft = self.knochenX * tmpX
        let barrierRight = (self.knochenX+1) * tmpX
        let barrierUnten = self.knochenY * tmpY
        let barrierOben = (self.knochenY + 1) * tmpY
        
        let movedToPoint = self.calcField(touchX: touchLocation!.x, touchY: touchLocation!.y, squareLength: tmpX, squareWidth: tmpY)
        
        let move = SKAction.move(to: movedToPoint, duration: 1.0)
        indy.run(SKAction.sequence([move, SKAction.run({
            if Int(touchLocation!.x) > barrierLeft && Int(touchLocation!.x) < barrierRight && Int(touchLocation!.y) > barrierUnten && Int(touchLocation!.y) < barrierOben{
                    
                self.win()
            } else {
                let schrittZeiger = SKLabelNode()
                print(movedToPoint)
                let schritte = self.differenzBerechnen(movedX: movedToPoint.x, movedY: movedToPoint.y)
                
                if schritte == 1{
                    schrittZeiger.text = "Sie sind einen Schritt entfernt"
                }else if schritte > 1 {
                    schrittZeiger.text = "Sie sind \(schritte) Schritte entfernt"
                }
                
                schrittZeiger.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
                schrittZeiger.alpha = 0.0
                self.addChild(schrittZeiger)
                
                self.run(SKAction.sequence([
                    SKAction.run {schrittZeiger.alpha = 1.0},
                    SKAction.wait(forDuration: 1.0),
                    SKAction.run {schrittZeiger.alpha = 0.0}
                ]))
            }
        })]))
    
    }
    
    func calcField(touchX: CGFloat, touchY: CGFloat, squareLength: Int, squareWidth: Int)->CGPoint{
        let fieldX = Int(touchX)/squareLength
        let fieldY = Int(touchY)/squareWidth
        
        var moveX = -1
        var moveY = -1
        
        if gamemode == modeStruct.easy{
            moveX = Int(self.size.width)/3*fieldX+(Int(self.size.width)/3)/2
            moveY = Int(self.size.height)/3*fieldY+(Int(self.size.height)/3)/2
        }else if gamemode == modeStruct.medium{
            moveX = Int(self.size.width)/5*fieldX+(Int(self.size.width)/5)/2
            moveY = Int(self.size.height)/5*fieldY+(Int(self.size.height)/5)/2
        }else if gamemode == modeStruct.hard{
            moveX = Int(self.size.width)/7*fieldX+(Int(self.size.width)/7)/2
            moveY = Int(self.size.height)/7*fieldY+(Int(self.size.height)/7)/2
        }
        
        
        
        
        return CGPoint(x: moveX, y: moveY)
    }
    
    func setKnochen(){
        if gamemode == modeStruct.easy{
            knochenX = Int(random(min: 0, max: 3))
            knochenY = Int(random(min: 0, max: 3))
            
            print(knochenX)
            print(knochenY)
            
            field[knochenX][knochenY] = SKSpriteNode(imageNamed: "Knochen")
            
        } else if gamemode == modeStruct.medium{
            knochenX = Int(random(min: 0, max: 5))
            knochenY = Int(random(min: 0, max: 5))
                   
            field[knochenX][knochenY] = SKSpriteNode(imageNamed: "Knochen")
                   
        } else if gamemode == modeStruct.hard{
            knochenX = Int(random(min: 0, max: 7))
            knochenY = Int(random(min: 0, max: 7))
                   
            field[knochenX][knochenY] = SKSpriteNode(imageNamed: "Knochen")
                   
        }

    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
      return CGFloat.random(in: min..<max)
    }
    
    func win(){
        let transition = SKTransition.flipHorizontal(withDuration: 0.5)
        let endScreen = EndScreen(size: size, didWin: true)
        view?.presentScene(endScreen, transition: transition)
        speicher.set(speicher.integer(forKey: "wins") + 1, forKey: "wins")
    }
    
    func differenzBerechnen(movedX: CGFloat, movedY: CGFloat) -> Int{
        var x = -1
        var y = -1
        
        var zaehler = 0
        
        if gamemode == modeStruct.easy{
            let max = 2
            while zaehler <= max {
                if Int((self.size.width/3))*zaehler < Int(movedX) && Int((self.size.width/3))*(zaehler+1) > Int(movedX){
                    x = zaehler
                }
                zaehler+=1
            }
        }else if gamemode == modeStruct.medium{
            let max = 4
            while zaehler <= max {
                if Int((self.size.width/5))*zaehler < Int(movedX) && Int((self.size.width/5))*(zaehler+1) > Int(movedX){
                    x = zaehler
                }
                zaehler+=1
            }
        }else if gamemode == modeStruct.hard{
            let max = 6
            while zaehler <= max {
                if Int((self.size.width/7))*zaehler < Int(movedX) && Int((self.size.width/7))*(zaehler+1) > Int(movedX){
                    x = zaehler
                }
                zaehler+=1
            }
        }
        
        zaehler = 0
        
        if gamemode == modeStruct.easy{
            let max = 2
            while zaehler <= max {
                if Int((self.size.height/3))*zaehler < Int(movedY) && Int((self.size.height/3))*(zaehler+1) > Int(movedY){
                    y = zaehler
                }
                zaehler+=1
            }
        }else if gamemode == modeStruct.medium{
            let max = 4
            while zaehler <= max {
                if Int((self.size.height/5))*zaehler < Int(movedY) && Int((self.size.height/5))*(zaehler+1) > Int(movedY){
                    y = zaehler
                }
                zaehler+=1
            }
        }else if gamemode == modeStruct.hard{
            let max = 6
            while zaehler <= max {
                if Int((self.size.height/7))*zaehler < Int(movedY) && Int((self.size.height/7))*(zaehler+1) > Int(movedY){
                    y = zaehler
                }
                zaehler+=1
            }
        }
        
        
        if Int(x) > knochenX{
            x = Int(x) - knochenX
        }else{
            x = knochenX - Int(x)
        }
        if Int(y) > knochenY {
            y = Int(y) - knochenY
        }else{
            y = knochenY - Int(y)
        }
        return x+y
    }
}
class Grid:SKSpriteNode {
    var rows:Int!
    var cols:Int!
    var blockSize:CGFloat!

    convenience init?(width:CGFloat,height:CGFloat,rows:Int,cols:Int) {
        guard let texture = Grid.gridTexture(width: width, height: height, rows: rows, cols: cols) else {
            return nil
        }
        self.init(texture: texture, color:SKColor.clear, size: texture.size())
        self.blockSize = blockSize
        self.rows = rows
        self.cols = cols
    }

    class func gridTexture(width:CGFloat,height: CGFloat,rows:Int,cols:Int) -> SKTexture? {
        
        let size = CGSize(width: CGFloat(cols)*width+1.0, height: CGFloat(rows)*height+1.0)
        UIGraphicsBeginImageContext(size)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let bezierPath = UIBezierPath()
        let offset:CGFloat = 0.5
        //Vertikal
        for i in 0...cols {
            let x = CGFloat(i)*width + offset
            bezierPath.move(to: CGPoint(x: x, y: 0))
            bezierPath.addLine(to: CGPoint(x: x, y: size.height))
        }
        // Horizontal
        for i in 0...rows {
            let y = CGFloat(i)*height + offset
            bezierPath.move(to: CGPoint(x: 0, y: y))
            bezierPath.addLine(to: CGPoint(x: size.width, y: y))
        }
        SKColor.black.setStroke()
        bezierPath.lineWidth = 1.0
        bezierPath.stroke()
        context.addPath(bezierPath.cgPath)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        

        return SKTexture(image: image!)
    }

    func gridPosition(row:Int, col:Int) -> CGPoint {
        
        return CGPoint(x: 0, y: 0)
    }
}
