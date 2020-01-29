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
    
    init(size: CGSize ,selected: Int) {
        super.init(size: size)
        if selected == 0{
            gamemode = modeStruct.easy
        }else if selected == 1{
            gamemode = modeStruct.medium
        }else if selected == 2{
            gamemode = modeStruct.hard
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        wiese = SKSpriteNode(color: SKColor(displayP3Red: 34/255, green: 139/255, blue: 34/255, alpha: 1), size: CGSize(width: self.size.width, height: self.size.height))
        wiese.position = CGPoint(x: wiese.size.width/2, y: wiese.size.height/2)
        indy.position = CGPoint(x: 100.0, y: 100.0)
        indy.size = CGSize(width: 30, height: 30)
        wiese.addChild(indy)
        self.addChild(wiese)
        
        field = Array<Array>(repeating: Array<SKSpriteNode>(repeating: SKSpriteNode(), count: 3), count: 3)
        
        setKnochen()
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Ich bin in Touch")
        let touches = touches.first
        let touchLocation = touches?.location(in: self)
        print(touchLocation)
        
        if gamemode == modeStruct.easy {
            let tmpX:Int = Int(wiese.size.width/3)
            let tmpY:Int = Int(wiese.size.height/3)
            
            
            let barrierLeft = self.knochenX * tmpX
            let barrierRight = (self.knochenX+1) * tmpX
            let barrierUnten = self.knochenY * tmpY
            let barrierOben = (self.knochenY+1) * tmpY
            
            print(barrierLeft, barrierRight, barrierUnten, barrierOben)
            
            if Int(touchLocation!.x) > barrierLeft && Int(touchLocation!.x) < barrierRight {
                if Int(touchLocation!.y) > barrierUnten && Int(touchLocation!.y) < barrierOben {
                    win()
                }
            }
        }
    }
    
    func setKnochen(){
        if gamemode == modeStruct.easy{
            knochenX = Int(random(min: 0, max: 2))
            knochenY = Int(random(min: 0, max: 2))
            
            print(knochenX)
            print(knochenY)
            
            field[knochenX][knochenY] = SKSpriteNode(imageNamed: "Knochen")
            
        }else  if gamemode == modeStruct.medium{
            knochenX = Int(random(min: 0, max: 4))
            knochenY = Int(random(min: 0, max: 4))
                   
            field[knochenX][knochenY] = SKSpriteNode(imageNamed: "Knochen")
                   
        }else  if gamemode == modeStruct.hard{
            knochenX = Int(random(min: 0, max: 6))
            knochenY = Int(random(min: 0, max: 6))
                   
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
    }
}

