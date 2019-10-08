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
    var lives = 3
    var  livesLabel:SKLabelNode!
    var score = 0
    var scoreLabel:SKLabelNode!
    var playerMovingLeft:Bool = false
    var playerMovingRight:Bool = false
    var MouseX:CGFloat = 0.0
    var MouseY:CGFloat = 0.0
    var ItemArray:[SKSpriteNode] = []
    override func didMove(to view: SKView) {
        self.player = SKSpriteNode(imageNamed: "dino64")
        self.player.position = CGPoint(x: 300, y: 300)
        addChild(player)
        
        self.livesLabel = SKLabelNode(text: "Lives:\(lives)")
        self.livesLabel.position = CGPoint(x: 300, y: 600)
        self.livesLabel.color = UIColor.white
        self.livesLabel.fontColor = UIColor.white
        self.livesLabel.fontSize = 35
        addChild(self.livesLabel)
        self.scoreLabel = SKLabelNode(text: "Score:\(self.score)")
        self.scoreLabel.position = CGPoint(x:75, y: 600)
        self.scoreLabel.fontSize = 35
        self.scoreLabel.fontColor = UIColor.white
        addChild(self.scoreLabel)
    }
    var candy:[SKSpriteNode] = []////////////////////////////////////////////////////////////////////////
    func spawnCandy(){
        let candy = SKSpriteNode(imageNamed: "candy64")
        let randomXPos = CGFloat.random(in:0 ... size.width)
        let randomYPos = CGFloat.random(in:0 ... size.height)
        candy.position = CGPoint(x: randomXPos, y: randomYPos)
        addChild(candy)
        self.candy.append(candy)
    }
    var rainbow:[SKSpriteNode] = []////////////////////////////////////////////////////////////////////////
    func spawnRainbow(){
        let rainbow = SKSpriteNode(imageNamed: "rainbow64")
        let randomXPos = CGFloat.random(in:0 ... size.width)
        let randomYPos = CGFloat.random(in:0 ... size.height)
        rainbow.position = CGPoint(x: randomXPos, y: randomYPos)
        addChild(rainbow)
        self.rainbow.append(rainbow)
    }
    var poop:[SKSpriteNode] = []////////////////////////////////////////////////////////////////////////
    func spawnPoop(){
        let poop = SKSpriteNode(imageNamed: "poop64")
        let randomXPos = CGFloat.random(in:0 ... size.width)
        let randomYPos = CGFloat.random(in:0 ... size.height)
        poop.position = CGPoint(x: randomXPos, y: randomYPos)
        addChild(poop)
        self.poop.append(poop)
    }
    
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
        let xn = (a / distance)
        let yn = (b / distance)
        //calculate the movement
        self.player.position.x = self.player.position.x + (xn * 40)
        self.player.position.y = self.player.position.y + (yn * 40)
    }
    var numLoops = 0
    override func update(_ currentTime: TimeInterval) {
        
        numLoops = numLoops + 1
        if(numLoops % 360 == 0){/////////////////////////////////////////////////////////////////////////////
            
            
            self.spawnCandy()
            
            
        }
        if(numLoops % 1200 == 0){/////////////////////////////////////////////////////////////////////////////
            
            
            self.spawnRainbow()
            
            
        }
        if(numLoops % 240 == 0){/////////////////////////////////////////////////////////////////////////////
            
            
            self.spawnPoop()
            
            
        }
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
        for (index, rainbow) in self.rainbow.enumerated(){
            if (self.player.frame.intersects(rainbow.frame) == true){
                self.score = self.score + 2
                self.scoreLabel.text = "Score: \(self.score)"
                // remove cat from screen
                rainbow.removeFromParent()
                // remove cat from array
                self.rainbow.remove(at:index)
                //let winScene = WinScene(size: self.size)
               // let transitionEffect = SKTransition.flipVertical(withDuration: 2)
                //self.view?.presentScene(winScene, transition:transitionEffect)
            }
        }
        if(score >= 5){
            let winScene = WinScene(size: self.size)
            let transitionEffect = SKTransition.flipVertical(withDuration: 2)
            self.view?.presentScene(winScene, transition:transitionEffect)
        }
        for (index, poop) in self.poop.enumerated(){
            if (self.player.frame.intersects(poop.frame) == true){
                self.lives = self.lives - 1
                self.livesLabel.text = "Lives: \(self.lives)"
                // remove cat from screen
                poop.removeFromParent()
                // remove cat from array
                self.poop.remove(at:index)
                if(lives <= 0){
                let loseScene = LoseScene(size: self.size)
                let transitionEffect = SKTransition.flipVertical(withDuration: 2)
                self.view?.presentScene(loseScene, transition:transitionEffect)
            }
        }
}
}
}
