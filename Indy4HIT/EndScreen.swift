//
//  EndScreen.swift
//  Indy4HIT
//
//  Created by Patrick Elias on 29.01.20.
//  Copyright © 2020 Florian Safer. All rights reserved.
//

import SpriteKit

class EndScreen: SKScene {
    
    init(size: CGSize, didWin: Bool) {
        super.init(size: size)
        
        let msg = didWin ? "You won the Game!" : "You lost the Game!"
        let text = SKLabelNode(fontNamed: "Arial")
        let restart = SKLabelNode(fontNamed: "Arial")
        backgroundColor = SKColor.black
        
        
        text.text = msg
        text.color = SKColor.white
        text.fontSize = 50
        text.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        restart.text = "Main Menu"
        restart.fontSize = 40
        restart.position = CGPoint(x: size.width / 2, y: size.height / 3)
        restart.name = "mainmenu"
        
        addChild(text)
        addChild(restart)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLoc = touch?.location(in: self)
        let touchedNodes = self.nodes(at: touchLoc!)
        let touchNode = touchedNodes.first
        switch touchNode?.name {
        case "mainmenu":
            print("mainmenu")
            run(SKAction.run {
                let trans = SKTransition.flipVertical(withDuration: 0.5)
                let s = MainMenu(size: self.size)
                self.view?.presentScene(s, transition: trans)
            })
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
