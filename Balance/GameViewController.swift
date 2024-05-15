//
//  GameViewController.swift
//  Balance
//
//  Created by Lazar, Viktor on 23/04/2024.
//
import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, MenuSceneDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Lock the device's orientation
        AppDelegate.AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)

        // Load 'MenuScene' at the beginning
        if let view = self.view as! SKView? {
            let scene = MenuScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            scene.menuDelegate = self
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Unlock the device's orientation when the view disappears
        AppDelegate.AppUtility.lockOrientation(.all)
    }
    
    // MARK: - MenuSceneDelegate
    
    func menuSceneStartButtonPressed() {
        print("Start button pressed in GameViewController")
        // Transition to GameScene when start button is pressed
        if let view = self.view as? SKView {
            let gameScene = GameScene(size: view.bounds.size)
            gameScene.scaleMode = .aspectFill
            view.presentScene(gameScene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}

extension AppDelegate {
    struct AppUtility {
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
            }
        }

        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
            self.lockOrientation(orientation)
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        }
    }
}
