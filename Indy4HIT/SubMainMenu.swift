//
//  SubMainMenu.swift
//  Indy4HIT
//
//  Created by Patrick Elias on 29.01.20.
//  Copyright © 2020 Florian Safer. All rights reserved.
//

import SpriteKit

class SubMainMenu: SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        let small = SKLabelNode(fontNamed: "Arial")
        let medium = SKLabelNode(fontNamed: "Arial")
        let large = SKLabelNode(fontNamed: "Arial")
        
        small.text = "Small Map"
        small.position = CGPoint(x: size.width / 2, y: size.height / 1.5)
        small.name = "small"
        
        medium.text = "Medium Map"
        medium.position = CGPoint(x: size.width / 2, y: size.height / 2)
        medium.name = "medium"
        
        large.text = "Large Map"
        large.position = CGPoint(x: size.width / 2, y: size.height / 3)
        large.name = "large"
        
        addChild(small)
        addChild(medium)
        addChild(large)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchloc = touch?.location(in: self)
        let touchNodes = self.nodes(at: touchloc!)
        let touchNode = touchNodes.first
        switch touchNode?.name {
        case "small":
            run(SKAction.run {
                let trans = SKTransition.flipHorizontal(withDuration: 0.5)
                let s = GameScene(size: self.size, selected: 0)
                self.view?.presentScene(s, transition: trans)
            })
        case "medium":
            run(SKAction.run {
                let trans = SKTransition.flipHorizontal(withDuration: 0.5)
                let s = GameScene(size: self.size, selected: 1)
                self.view?.presentScene(s, transition: trans)
            })
        case "large":
            run(SKAction.run {
                let trans = SKTransition.flipHorizontal(withDuration: 0.5)
                let s = GameScene(size: self.size, selected: 2)
                self.view?.presentScene(s, transition: trans)
            })
        default:
            break
        }
    }
}
