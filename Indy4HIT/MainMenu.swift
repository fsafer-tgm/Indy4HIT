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
        
        toplist.text = "Top List"
        toplist.fontSize = 30
        toplist.position = CGPoint(x: size.width / 2, y: size.height / 3)
        
        addChild(startGame)
        addChild(newgame)
        addChild(toplist)
    }
}
