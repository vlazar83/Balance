//
//  Player.swift
//  Balance
//
//  Created by Lazar, Viktor on 23/04/2024.
//

import SpriteKit
import GameplayKit
import CoreMotion

class Player: SKShapeNode {

    let motionManager = CMMotionManager()
//    var speed: CGFloat = 100.0

    override init() {
        super.init()
        
        let circle = SKShapeNode(circleOfRadius: 25)
        circle.fillColor = .red
        circle.strokeColor = .clear
        addChild(circle)
        
        self.name = "player"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startMotionUpdates() {
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.1
            motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
                if let gyroData = data {
                    let rotationRate = gyroData.rotationRate
                    self.move(rotationRate: rotationRate)
                }
            }
        }
    }

    func move(rotationRate: CMRotationRate) {
        let moveAction = SKAction.moveBy(x: CGFloat(rotationRate.x * speed), y: 0, duration: 0.1)
        self.run(moveAction)
    }
}
