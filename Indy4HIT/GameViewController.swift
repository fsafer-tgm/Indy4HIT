//
//  GameViewController.swift
//  Indy4HIT
//
//  Created by Florian Safer on 29.01.20.
//  Copyright © 2020 Florian Safer. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
<<<<<<< HEAD
        //let scene = MainMenu(size: view.bounds.size)
        let scene = GameScene(size: view.bounds.size, selected: 0)
=======
        let scene = MainMenu(size: view.bounds.size)
>>>>>>> 526d5e25602563d34e8ce1dec44a0821bf3d3cae
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
}
