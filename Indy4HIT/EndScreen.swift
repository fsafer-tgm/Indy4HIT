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
        let playImg = SKSpriteNode(imageNamed: "playIcon")
        let winLabel = SKLabelNode(fontNamed: "Arial")
        let speicher = UserDefaults.standard
        let wins = speicher.integer(forKey: "wins")
        
        text.text = msg
        text.fontSize = size.height / 5
        text.position = CGPoint(x: size.width / 2, y: size.height / 2 * 1.5)
        text.fontColor = didWin ? SKColor.green : SKColor.red
        
        restart.text = "Back"
        restart.fontSize = size.height / 10
        restart.position = CGPoint(x: size.width / 2, y: size.height / 3)
        restart.name = "mainmenu"
         
        img.position = CGPoint(x: size.width / 2 - restart.fontSize * 4 / 2, y: restart.position.y + restart.frame.size.height / 2 - 1)
        img.size = CGSize(width: restart.frame.size.height, height: restart.frame.size.height)
        img.name = "arrow"
        
        effect?.position = CGPoint(x: size.width / 2, y: size.height / 2 - size.height)
        effect?.zPosition = -9999
        
        playAgain.text = "Play Again"
        playAgain.fontSize = size.height / 10
        playAgain.position = CGPoint(x: size.width / 2, y: size.height / 2)
        playAgain.name = "playAgain"
        
        playImg.position = CGPoint(x: size.width / 2 - playAgain.fontSize * 6.5 / 2, y: playAgain.position.y + playAgain.frame.size.height / 2 - 1)
        playImg.size = CGSize(width: playAgain.frame.size.height, height: playAgain.frame.size.height)
        playImg.name = "playButton"
        
        winLabel.text = "Wins: \(wins)"
        winLabel.fontSize = size.height / 16
        winLabel.name = "winlabel"
        winLabel.position = CGPoint(x: size.width - size.height / 6, y: size.height - size.height / 13)
        
        addChild(playImg)
        addChild(effect!)
        addChild(img)
        addChild(text)
        addChild(restart)
        addChild(playAgain)
        addChild(winLabel)
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
                let trans = SKTransition.flipHorizontal(withDuration: 0.5)
                let s = MainMenu(size: self.size)
                self.view?.presentScene(s, transition: trans)
            })
        case "playAgain":
            run(SKAction.run {
                let trans = SKTransition.flipVertical(withDuration: 0.5)
                let s = SubMainMenu(size: self.size)
                self.view?.presentScene(s, transition: trans)
            })
        case "playButton":
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
