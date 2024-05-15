//
//  MenuScene.swift
//  Balance
//
//  Created by Lazar, Viktor on 23/04/2024.
//
import SpriteKit

protocol MenuSceneDelegate: AnyObject {
    func menuSceneStartButtonPressed()
}

class MenuScene: SKScene {

    weak var menuDelegate: MenuSceneDelegate?

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        createMenu()
    }
    
    func createMenu() {
        let startButton = SKLabelNode(text: "Start")
        startButton.name = "startButton"
        startButton.fontSize = 40
        startButton.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        addChild(startButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "startButton" {
                print("Start button pressed")
                menuDelegate?.menuSceneStartButtonPressed()
            }
        }
    }
}
