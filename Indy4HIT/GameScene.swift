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
        wiese = SKSpriteNode(color: SKColor(displayP3Red: 34/255, green: 139/255, blue: 34/255, alpha: 1), size: CGSize(width: self.size.width-100, height: self.size.height))
        wiese.position = CGPoint(x: 100+wiese.size.width/2, y: 0+wiese.size.height/2)
        indy.position = CGPoint(x: 100.0, y: 100.0)
        indy.size = CGSize(width: 30, height: 30)
        wiese.addChild(indy)
        self.addChild(wiese)
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touches = touches.first
        let touchLocation = touches?.location(in: self)
        
        if gamemode == modeStruct.easy {
            var tmpX = wiese.size.width/3
            var tmpY = wiese.size.height/3
        }
    }
    
    func setKnochen(){
        if gamemode == modeStruct.easy{
            let knochenX = Int(random(min: 0, max: 2))
            let knochenY = Int(random(min: 0, max: 2))
            
            field[knochenX][knochenY] = SKSpriteNode(imageNamed: "Knochen")
            
        }else  if gamemode == modeStruct.medium{
            let knochenX = Int(random(min: 0, max: 4))
            let knochenY = Int(random(min: 0, max: 4))
                   
            field[knochenX][knochenY] = SKSpriteNode(imageNamed: "Knochen")
                   
        }else  if gamemode == modeStruct.hard{
            let knochenX = Int(random(min: 0, max: 6))
            let knochenY = Int(random(min: 0, max: 6))
                   
            field[knochenX][knochenY] = SKSpriteNode(imageNamed: "Knochen")
                   
        }

    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
      return CGFloat.random(in: min..<max)
    }
}

