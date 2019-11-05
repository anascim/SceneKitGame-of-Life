//
//  GameViewController.swift
//  Game of Life
//
//  Created by Alex Nascimento on 31/10/19.
//  Copyright © 2019 Alex Nascimento. All rights reserved.
//

import SceneKit
import QuartzCore

class GameViewController: NSViewController {
    
    var lastGrid: Grid!
    var game: GameOfLife!
    var paused: Bool = true
    let scene = GameScene()
    var pool: Pool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // create a new scene
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        
        // set the scene to the view
        scnView.scene = scene
        scnView.loops = true
        scnView.isPlaying = true
        scnView.delegate = scene
        scnView.pointOfView = scene.cameraNode
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = NSColor.black
        
        // Add a click gesture recognizer
        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
        var gestureRecognizers = scnView.gestureRecognizers
        gestureRecognizers.insert(clickGesture, at: 0)
        scnView.gestureRecognizers = gestureRecognizers
    }
    
    override func keyDown(with event: NSEvent) {
//        print("keyCode: \(event.keyCode)")
        if event.keyCode == 49 {
            scene.spaceKey()
        }
        if event.keyCode == 36 {
            scene.enterKey()
        }
    }
    
    @objc
    func handleClick(_ gestureRecognizer: NSGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are clicked
        let p = gestureRecognizer.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
//            if let cell = result.node as? Cell {
//                cell.state = 1
//            }
        }
    }
}
