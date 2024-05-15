//
//  Obstacle.swift
//  Balance
//
//  Created by Lazar, Viktor on 23/04/2024.
//

import SpriteKit
import GameplayKit

class Obstacle: SKSpriteNode {

    init() {
        let texture = SKTexture(imageNamed: "obstacle")
        super.init(texture: texture, color: .clear, size: texture.size())
        self.name = "obstacle"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
