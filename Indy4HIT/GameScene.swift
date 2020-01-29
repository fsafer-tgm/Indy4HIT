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
        indy.size = CGSize(width: 100, height: 100)
        self.addChild(wiese)
        self.addChild(indy)

        field = Array<Array>(repeating: Array<SKSpriteNode>(repeating: SKSpriteNode(), count: 3), count: 3)
        
        setKnochen()
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touches = touches.first
        let touchLocation = touches?.location(in: self)
        
        if gamemode == modeStruct.easy {
            let tmpX:Int = Int(wiese.size.width/3)
            let tmpY:Int = Int(wiese.size.height/3)
            
            
            print(tmpX, tmpY)
            let barrierLeft = self.knochenX * tmpX
            let barrierRight = (self.knochenX+1) * tmpX
            let barrierUnten = self.knochenY * tmpY
            let barrierOben = (self.knochenY + 1) * tmpY
            
            let move = SKAction.move(to: touchLocation!, duration: 1.0)
            indy.run(SKAction.sequence([move, SKAction.run({
                if Int(touchLocation!.x) > barrierLeft && Int(touchLocation!.x) < barrierRight && Int(touchLocation!.y) > barrierUnten && Int(touchLocation!.y) < barrierOben{
                    
                    self.win()
                } else {
                    let schrittZeiger = SKLabelNode()
                    let schritte = self.differenzBerechnen(touchX: touchLocation!.x, touchY: touchLocation!.y, squareLength: tmpX, squareWidth: tmpY)
                    
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
    
    func differenzBerechnen(touchX: CGFloat, touchY: CGFloat, squareLength: Int, squareWidth: Int) -> Int{
        let fieldX = Int(touchX)/squareLength
        let fieldY = Int(touchY)/squareWidth
        
        return abs((fieldX-knochenX)+(fieldY-knochenY))
    }
}

