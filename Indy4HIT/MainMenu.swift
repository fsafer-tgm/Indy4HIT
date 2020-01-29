//
//  MainMenu.swift
//  Indy4HIT
//
//  Created by Patrick Elias on 29.01.20.
//  Copyright © 2020 Florian Safer. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    override func didMove(to view: SKView) {
        let startGame = SKLabelNode(fontNamed: "Arial")
        let newgame = SKLabelNode(fontNamed: "Arial")
        let toplist = SKLabelNode(fontNamed: "Arial")
        let effect1 = SKEffectNode(fileNamed: "winEffect")
        let effect2 = SKEffectNode(fileNamed: "winEffect")
        let indy = SKSpriteNode(imageNamed: "Indy")
        
        indy.name = "indyImg"
        indy.zPosition = -9999
        indy.position = CGPoint(x: size.width / 2, y: size.height / 2 + size.height / 3)
        indy.size = CGSize(width: size.height / 5, height: size.height / 5)
        
        startGame.text = "Continue Game"
        startGame.fontSize = size.height / 13
        startGame.position = CGPoint(x: size.width / 2, y: size.height / 1.5)
        startGame.name = "contgame"
        
        newgame.text = "New Game"
        newgame.fontSize = size.height / 13
        newgame.position = CGPoint(x: size.width / 2, y: size.height / 2)
        newgame.name = "newgame"
        
        toplist.text = "Top List"
        toplist.fontSize = size.height / 13
        toplist.position = CGPoint(x: size.width / 2, y: size.height / 3)
        toplist.name = "toplist"
        
        effect1?.zPosition = -9999
        effect2?.zPosition = -9999
        effect1?.position = CGPoint(x: size.width / 2 - size.width / 1.8, y: size.height / 2 - size.height)
        effect2?.position = CGPoint(x: size.width / 2 + size.width / 1.8, y: size.height / 2 - size.height)
        
        addChild(startGame)
        addChild(newgame)
        addChild(toplist)
        addChild(effect1!)
        addChild(effect2!)
        addChild(indy)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchloc = touch?.location(in: self)
        let touchNodes = self.nodes(at: touchloc!)
        let touchNode = touchNodes.first
        switch touchNode?.name {
        case "newgame":
            run(SKAction.run {
                let trans = SKTransition.flipVertical(withDuration: 0.5)
                let s = SubMainMenu(size: self.size)
                self.view?.presentScene(s, transition: trans)
            })
        case "toplist":
            run(SKAction.run {
                let trans = SKTransition.flipVertical(withDuration: 0.5)
                let s = EndScreen(size: self.size, didWin: true)
                self.view?.presentScene(s, transition: trans)
            })
        case "contgame":
            break
        default:
            break
        }
    }
}
