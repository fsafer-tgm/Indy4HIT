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
        let scene = EndScreen(size: view.bounds.size, didWin: true)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }


}
