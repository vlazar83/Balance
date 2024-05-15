//
//  GameScene.swift
//  Balance
//
//  Created by Lazar, Viktor on 23/04/2024.
//
import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    let motionManager = CMMotionManager()
    var lastRotationRate: CMRotationRate?
    var velocityX: CGFloat = 0
    var velocityY: CGFloat = 0
    var previousTimeInterval: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        createCircle()
    }
    
    func createCircle() {
        let circle = SKShapeNode(circleOfRadius: 50)
        circle.fillColor = .red
        circle.name = "circle"
        circle.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        addChild(circle)
        startGyroscope()
    }
    
    func startGyroscope() {
        if motionManager.isGyroAvailable {
            motionManager.startGyroUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self else { return }
                if let rotationRate = data?.rotationRate {
                    self.moveCircle(rotationRate: rotationRate)
                }
            }
        } else {
            print("Gyroscope is not available")
        }
    }
    
    func moveCircle(rotationRate: CMRotationRate) {
        // Dampening factor
        let dampeningFactor: CGFloat = 0.1
        
        // Sensitivity, you can adjust this value
        let sensitivity: CGFloat = 50.0
        
        var dx = CGFloat(rotationRate.y) * sensitivity
        var dy = CGFloat(rotationRate.x) * sensitivity
        
        if let lastRotationRate = lastRotationRate {
            dx = dampeningFactor * CGFloat(rotationRate.y) + (1 - dampeningFactor) * CGFloat(lastRotationRate.y)
            dy = dampeningFactor * CGFloat(rotationRate.x) + (1 - dampeningFactor) * CGFloat(lastRotationRate.x)
        }
        
        lastRotationRate = rotationRate
        
        let currentTimeInterval = Date().timeIntervalSince1970
        
        // Calculate velocity
        if previousTimeInterval > 0 {
            let deltaTime = CGFloat(currentTimeInterval - previousTimeInterval)
            velocityX += dx * deltaTime
            velocityY -= dy * deltaTime  // Invert the y-axis movement
        }
        previousTimeInterval = currentTimeInterval
        
        // Move the circle based on the gyroscope data
        self.enumerateChildNodes(withName: "circle") { (node, _) in
            var newX = node.position.x + self.velocityX
            var newY = node.position.y + self.velocityY
            
            // Constrain the circle within the screen
            let halfWidth = node.frame.width / 2
            let halfHeight = node.frame.height / 2
            let minX = halfWidth
            let maxX = self.size.width - halfWidth
            let minY = halfHeight
            let maxY = self.size.height - halfHeight
            
            if newX < minX {
                newX = minX
                self.velocityX = 0 // Stop the velocity when hitting the boundary
            } else if newX > maxX {
                newX = maxX
                self.velocityX = 0
            }
            
            if newY < minY {
                newY = minY
                self.velocityY = 0
            } else if newY > maxY {
                newY = maxY
                self.velocityY = 0
            }
            
            node.position = CGPoint(x: newX, y: newY)
        }
    }
    
    deinit {
        motionManager.stopGyroUpdates()
    }
    
}
