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
    
    var rainbow:SKSpriteNode!
    var poop:SKSpriteNode!
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
    var candy:[SKSpriteNode] = []////////////////////
    func spawnCandy(){
        let candy = SKSpriteNode(imageNamed: "candy64")
        let randomXPos = CGFloat.random(in:0 ... size.width)
        let randomYPos = CGFloat.random(in:0 ... size.height)
        candy.position = CGPoint(x: randomXPos, y: randomYPos)
        addChild(candy)
        self.candy.append(candy)
    }
    
    // just to move player according to mouse click
    func movePlayer(mouseXPosition:CGFloat,mouseYPosition:CGFloat)  {
        //1. calculate didtance
        let a = (self.MouseX - self.player.position.x)
        let b = (self.MouseY - self.player.position.y)
        let distance = sqrt((a * a) + (b * b))
        
        //2. movement per rate
        
        let yn = (b / distance)
       let xn = (b / distance)
        //calculate the movement
        
        self.player.position.y = self.player.position.y + (yn * 40)
        self.player.position.x = self.player.position.x + (xn * 40)
    }
    var numLoops = 0
    override func update(_ currentTime: TimeInterval) {
        
        numLoops = numLoops + 1
        if(numLoops % 120 == 0){/////////////////////////////////////////////////////////////////////////////
            
            
            self.spawnCandy()
            
            
        
    
    // get current y position of player
    
            let screenRightSide = size.width
            
            // get current x-position of zombie
            var playerX = self.player.position.x
            
            if (self.playerMovingLeft == true) {
                playerX = self.player.position.x - 10;
                
                if (playerX <= 0) {
                    // bounce off left wall
                    self.playerMovingRight = false;
                    self.playerMovingLeft = false;
                    
                }
            }
            
            if (self.playerMovingRight == true) {
                playerX = self.player.position.x + 10;
                
                if (playerX >= screenRightSide) {
                    // bounce off right wall
                    self.playerMovingLeft = false
                    self.playerMovingRight = false
                }
            }
        
    if(MouseY != 0.0 && MouseX != 0.0){
    self.movePlayer(mouseXPosition: self.MouseX, mouseYPosition: self.MouseY)
        }
        
    }
}
}
