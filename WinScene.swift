//
//  WinScene.swift
//  DianosourRainbow
//
//  Created by Akshdeep Kaur on 2019-10-08.
//  Copyright © 2019 Akshdeep Kaur. All rights reserved.
//

import Foundation
import SpriteKit
import Foundation
import SpriteKit
class WinScene:SKScene{
    var score = 5
    var scoreLabel:SKLabelNode!
    override init(size: CGSize) {
        super.init(size:size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        let bgNode = SKSpriteNode(imageNamed: "YouWin")
        bgNode.position = CGPoint(x:self.size.width/2,
                                  y:self.size.height/2)
        bgNode.zPosition = -1
        addChild(bgNode)
        self.scoreLabel = SKLabelNode(text: "Score:\(self.score)")
        self.scoreLabel.position = CGPoint(x:self.size.width/2,y: 200)
        self.scoreLabel.fontSize = 88
        self.scoreLabel.fontColor = UIColor.white
        addChild(self.scoreLabel)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // when person touches screen, show the main screen
        let mainGameScreen = ViewController(size:self.size)
        self.view?.presentScene(mainGameScreen)
    }
}
