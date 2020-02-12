//
//  GameScene.swift
//  DianosourRainbow
//
//  Created by Akshdeep Kaur on 2019-10-04.
//  Copyright © 2019 Akshdeep Kaur. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player:SKSpriteNode!
    
    var score = 0
    var scoreLabel:SKLabelNode!
    var playerMovingLeft:Bool = false
    var playerMovingRight:Bool = false
    var MouseX:CGFloat = 0.0
    var MouseY:CGFloat = 0.0
    var ItemArray:[SKSpriteNode] = []
    var enemyChoice:String = ""
    
    override func didMove(to view: SKView) {
        
               // getting player choice
               let playerChoice:String = {return self.userData?["player"] as? String ?? "empty data passed"}()
        // getting player choice
        self.enemyChoice = {return self.userData?["enemy"] as? String ?? "empty data passed"}()
             print("enemy selected: \(enemyChoice)")
        
        self.player = SKSpriteNode(imageNamed: "\(playerChoice)")
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        addChild(player)
        
//
        self.scoreLabel = SKLabelNode(text: "Score:\(self.score)")
        self.scoreLabel.position = CGPoint(x:75, y: 600)
        self.scoreLabel.fontSize = 35
        self.scoreLabel.fontColor = UIColor.white
        addChild(self.scoreLabel)
       
    }
    func random() -> CGFloat {
      return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }

    func random(min: CGFloat, max: CGFloat) -> CGFloat {
      return random() * (max - min) + min
    }
    var candy:[SKSpriteNode] = []////////////////////////////////////////////////////////////////////////
    func spawnCandy(){
        let candy = SKSpriteNode(imageNamed: "\(enemyChoice)")
        let actualY = random(min: candy.size.height/2 , max: size.height - candy.size.height/2)
        candy.position = CGPoint(x: size.width + candy.size.width/2, y: actualY)
        addChild(candy)
        self.candy.append(candy)
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: -candy.size.width/2, y: actualY),
                                       duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        candy.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
//
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // get the first "tap" on the screen
        let locationtouched = touches.first
        
        if (locationtouched == nil) {
            // if for some reason the "tap" return as null, then exit
            return
        }
        let mousePosition = locationtouched!.location(in:self)
        print("mouseX = \(mousePosition.x)")
        print("mouseY = \(mousePosition.y)")
        print("-------")
        
        self.MouseX = mousePosition.x
        self.MouseY = mousePosition.y
        
        
        let touchLocation = locationtouched!.location(in: self)
        
        print("User tapped screen at: \(touchLocation.x.rounded()),\(touchLocation.y.rounded())")
    }
    func movePlayer(mouseXPosition:CGFloat,mouseYPosition:CGFloat)  {
        //1. calculate didtance
        let a = (self.MouseX - self.player.position.x)
        let b = (self.MouseY - self.player.position.y)
        let distance = sqrt((a * a) + (b * b))
        
        //2. movement per rate
      //  let xn = (a / distance)
        let yn = (b / distance)
        //calculate the movement
       // self.player.position.x = self.player.position.x + (xn * 40)
        self.player.position.y = self.player.position.y + (yn * 40)
    }
    var numLoops = 0
    override func update(_ currentTime: TimeInterval) {
        
        numLoops = numLoops + 1
        if(numLoops % 360 == 0){/////////////////////////////////////////////////////////////////////////////
            
            
            self.spawnCandy()
            
            
        }
//
        let screenRightSide = size.width
        
        // get current x-position of zombie
        var playerX = self.player.position.x
        
        if (self.playerMovingLeft == true) {
            playerX = self.player.position.x - 10;
            
            if (playerX <= 0) {
                // bounce off left wall
                self.playerMovingRight = true;
                self.playerMovingLeft = false;
                
            }
        }
        
        if (self.playerMovingRight == true) {
        playerX = self.player.position.x + 10;
            
            if (playerX >= screenRightSide) {
                // bounce off right wall
                self.playerMovingLeft = true
                self.playerMovingRight = false
            }
        }
        
        if(MouseY != 0.0 && MouseX != 0.0){
            self.movePlayer(mouseXPosition: self.MouseX, mouseYPosition: self.MouseY)
        }
        for (index, candy) in self.candy.enumerated(){
            if (self.player.frame.intersects(candy.frame) == true){
                self.score = self.score + 1
                self.scoreLabel.text = "Score: \(self.score)"
                // remove candy from screen
                candy.removeFromParent()
                // remove candy from array
                self.candy.remove(at:index)
                //let winScene = WinScene(size: self.size)
               // let transitionEffect = SKTransition.flipVertical(withDuration: 2)
                //self.view?.presentScene(winScene, transition:transitionEffect)
            }
        }
//
        if(score >= 5){
            let winScene = WinScene(size: self.size)
            let transitionEffect = SKTransition.flipVertical(withDuration: 2)
            self.view?.presentScene(winScene, transition:transitionEffect)
        }
//        
//        }
}
}

