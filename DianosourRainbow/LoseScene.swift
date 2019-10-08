//
//  LoseScene.swift
//  ZombieConga
//
//  Created by Akshdeep Kaur on 2019-10-01.
//  Copyright © 2019 Parrot. All rights reserved.
//

import Foundation
import SpriteKit
import Foundation
import SpriteKit
class LoseScene:SKScene{
    override init(size: CGSize) {
        super.init(size:size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        let bgNode = SKSpriteNode(imageNamed: "YouLose")
        bgNode.position = CGPoint(x:self.size.width/2,
                                  y:self.size.height)
        bgNode.zPosition = -1
        addChild(bgNode)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                // when person touches screen, show the main screen
                let mainGameScreen = GameScene(size:self.size)
                self.view?.presentScene(mainGameScreen)
            }
}

