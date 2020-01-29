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
        
        let effect = SKEffectNode(fileNamed: "winEffect")
        let msg = didWin ? "You won the Game!" : "You lost the Game!"
        let text = SKLabelNode(fontNamed: "Arial")
        let restart = SKLabelNode(fontNamed: "Arial")
        let img = SKSpriteNode(imageNamed: "backArrow")
        let playAgain = SKLabelNode(fontNamed: "Arial")
        
        text.text = msg
        text.fontSize = 80
        text.position = CGPoint(x: size.width / 2, y: size.height / 2 * 1.5)
        text.fontColor = didWin ? SKColor.green : SKColor.red
        
        restart.text = "Back"
        restart.fontSize = 40
        restart.position = CGPoint(x: size.width / 2, y: size.height / 3)
        restart.name = "mainmenu"
         
        img.position = CGPoint(x: size.width / 2 - restart.fontSize * 4 / 2, y: restart.position.y + restart.frame.size.height / 2 - 1)
        img.size = CGSize(width: restart.frame.size.height, height: restart.frame.size.height)
        img.name = "arrow"
        
        effect?.position = CGPoint(x: size.width / 2, y: size.height / 2 - size.height)
        effect?.zPosition = -9999
        
        playAgain.text = "Play Again"
        playAgain.fontSize = 40
        playAgain.position = CGPoint(x: size.width / 2, y: size.height / 2)
        playAgain.name = "playAgain"
        
        addChild(effect!)
        addChild(img)
        addChild(text)
        addChild(restart)
        addChild(playAgain)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLoc = touch?.location(in: self)
        let touchedNodes = self.nodes(at: touchLoc!)
        let touchNode = touchedNodes.first
        switch touchNode?.name {
        case "mainmenu":
            run(SKAction.run {
                let trans = SKTransition.flipVertical(withDuration: 0.5)
                let s = MainMenu(size: self.size)
                self.view?.presentScene(s, transition: trans)
            })
        case "arrow":
            run(SKAction.run {
                let trans = SKTransition.flipVertical(withDuration: 0.5)
                let s = MainMenu(size: self.size)
                self.view?.presentScene(s, transition: trans)
            })
        case "playAgain":
            run(SKAction.run {
                let trans = SKTransition.flipVertical(withDuration: 0.5)
                let s = SubMainMenu(size: self.size)
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
