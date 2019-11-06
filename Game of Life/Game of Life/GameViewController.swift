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
    @IBOutlet weak var sceneView: SCNView!
    
    @IBOutlet weak var stepBtn: NSButton!
    @IBAction func clickStepBtn(_ sender: Any) {
        scene.step()
    }
    
    @IBOutlet weak var runBtn: NSButton!
    @IBAction func clickRunBtn(_ sender: Any) {
        if !scene.running {
            scene.running = true
            runBtn.title = "Stop"
        } else {
            scene.running = false
            runBtn.title = "Run"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.scene = scene
        sceneView.loops = true
        sceneView.isPlaying = true
        sceneView.delegate = scene
        sceneView.pointOfView = scene.cameraNode
        
        // allows the user to manipulate the camera
//        sceneView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // configure the view
        sceneView.backgroundColor = NSColor.black
        
        // Add a click gesture recognizer
        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
        var gestureRecognizers = sceneView.gestureRecognizers
        gestureRecognizers.insert(clickGesture, at: 0)
        sceneView.gestureRecognizers = gestureRecognizers
    }
    
    override func keyDown(with event: NSEvent) {
        if event.keyCode == 49 {
            scene.spaceKey()
        }
        if event.keyCode == 36 {
            scene.enterKey()
        }
    }
    
    @objc
    func handleClick(_ gestureRecognizer: NSGestureRecognizer) {
        let p = gestureRecognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
        }
    }
}
