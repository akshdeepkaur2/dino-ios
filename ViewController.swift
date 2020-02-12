//
//  ViewController.swift
//  DianosourRainbow
//
//  Created by Akshdeep Kaur on 2020-02-06.
//  Copyright © 2020 Akshdeep Kaur. All rights reserved.
//

import Foundation
import SpriteKit
import Foundation
import SpriteKit
class ViewController:SKScene{
    var MouseX:CGFloat = 0.0
       var MouseY:CGFloat = 0.0
    let player1 = "dino64"
    let player2 = "rainbow64"
    let enemy1 = "poop64"
    let enemy2 = "candy64"

override init(size: CGSize) {
    super.init(size:size)
    
}
    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    override func didMove(to view: SKView) {
        let background = SKColor()
        self.backgroundColor  = UIColor.yellow
           let bgNode = SKSpriteNode(imageNamed: "play")
           bgNode.position = CGPoint(x:self.size.width/2,
                                     y:self.size.height/2)
           bgNode.zPosition = -1
           addChild(bgNode)
    }
       override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
           // when person touches screen, show the main screen
//           let mainGameScreen = GameScene(size:self.size)
//           self.view?.presentScene(mainGameScreen)
        
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
        //  getting screeen width
               let screenSize = UIScreen.main.bounds
               let screenWidth = screenSize.width
               
               let touchLocation = locationtouched!.location(in: self)
        if(touchLocation.x.rounded() <= screenWidth/2 )
        {
            print("user touched the PLAYER-1 button")
            
                       let mainGameScreen = GameScene(size:self.size)
            mainGameScreen.scaleMode = self.scaleMode
            mainGameScreen.userData = mainGameScreen.userData ?? NSMutableDictionary() //This lets us ensure userdata exists
            mainGameScreen.userData!["player"] = self.player1
            mainGameScreen.userData!["enemy"] = self.enemy1
            let sceneTransition = SKTransition.fade(withDuration: 0.4)
                       self.view?.presentScene(mainGameScreen,transition: sceneTransition)
            
        }
        else{
             print("user touched the PLAYER-2 button")
            let mainGameScreen = GameScene(size:self.size)
            mainGameScreen.scaleMode = self.scaleMode
            mainGameScreen.userData = mainGameScreen.userData ?? NSMutableDictionary() //This lets us ensure userdata exists
            mainGameScreen.userData!["player"] = self.player2
            mainGameScreen.userData!["enemy"] = self.enemy2
            let sceneTransition = SKTransition.fade(withDuration: 0.4)
                       self.view?.presentScene(mainGameScreen,transition: sceneTransition)
        }
               
               print("User tapped screen at: \(touchLocation.x.rounded()),\(touchLocation.y.rounded())")
       }
}
