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
        backgroundColor = SKColor.black
        
        let startGame = SKLabelNode(fontNamed: "Arial")
        let newgame = SKLabelNode(fontNamed: "Arial")
        let toplist = SKLabelNode(fontNamed: "Arial")
        
        startGame.text = "Continue Game"
        startGame.fontSize = 30
        startGame.position = CGPoint(x: size.width / 2, y: size.height / 1.5)
        startGame.color = SKColor.white
        
        newgame.text = "New Game"
        newgame.fontSize = 30
        newgame.position = CGPoint(x: size.width / 2, y: size.height / 2)
        newgame.name = "newgame"
        
        toplist.text = "Top List"
        toplist.fontSize = 30
        toplist.position = CGPoint(x: size.width / 2, y: size.height / 3)
        
        addChild(startGame)
        addChild(newgame)
        addChild(toplist)
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
                let s = GameScene(size: self.size, selected: 0)
                self.view?.presentScene(s, transition: trans)
            })
        default:
            break
        }
    }
}
