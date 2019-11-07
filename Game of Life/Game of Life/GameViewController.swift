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
    
    var game: GameOfLife!
    var scene: GameScene!
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
    
    @IBOutlet weak var speedTextField: NSTextField!
    @IBAction func speedTextFieldA(_ sender: Any) {
        if let speedValue = Double(speedTextField.stringValue) {
            scene.interval = speedValue
        } else {
            scene.interval = 0.05
        }
    }
    
    @IBOutlet weak var colorWell1: NSColorWell!
    @IBAction func colorWell1A(_ sender: Any) {
        pool.coloredCubes[0].firstMaterial?.diffuse.contents = colorWell1.color
    }
    @IBOutlet weak var colorWell2: NSColorWell!
    @IBAction func colorWell2A(_ sender: Any) {
        pool.coloredCubes[1].firstMaterial?.diffuse.contents = colorWell2.color
    }
    
    @IBOutlet weak var colorWell3: NSColorWell!
    @IBAction func colorWell3A(_ sender: Any) {
        pool.coloredCubes[2].firstMaterial?.diffuse.contents = colorWell3.color
    }
    @IBOutlet weak var colorWell4: NSColorWell!
    @IBAction func colorWell4A(_ sender: Any) {
        pool.coloredCubes[3].firstMaterial?.diffuse.contents = colorWell4.color
    }
    @IBOutlet weak var colorWell5: NSColorWell!
    @IBAction func colorWell5A(_ sender: Any) {
        pool.coloredCubes[4].firstMaterial?.diffuse.contents = colorWell5.color
    }
    @IBOutlet weak var colorWell6: NSColorWell!
    @IBAction func colorWell6A(_ sender: Any) {
        pool.coloredCubes[5].firstMaterial?.diffuse.contents = colorWell6.color
    }
    @IBOutlet weak var colorWell7: NSColorWell!
    @IBAction func colorWell7A(_ sender: Any) {
        pool.coloredCubes[6].firstMaterial?.diffuse.contents = colorWell7.color
    }
    
    @IBOutlet weak var colorWell8: NSColorWell!
    @IBAction func colorWell8A(_ sender: Any) {
        pool.coloredCubes[7].firstMaterial?.diffuse.contents = colorWell8.color
    }
    @IBOutlet weak var colorWell9: NSColorWell!
    
    @IBAction func colorWell9A(_ sender: Any) {
        pool.coloredCubes[8].firstMaterial?.diffuse.contents = colorWell9.color
    }
    @IBOutlet weak var colorWell10: NSColorWell!
    @IBAction func colorWell10A(_ sender: Any) {
        pool.coloredCubes[9].firstMaterial?.diffuse.contents = colorWell10.color
    }
    @IBOutlet weak var colorWell11: NSColorWell!
    @IBAction func colorWell11A(_ sender: Any) {
        pool.coloredCubes[10].firstMaterial?.diffuse.contents = colorWell11.color
    }
    @IBOutlet weak var colorWell12: NSColorWell!
    @IBAction func coloWell12A(_ sender: Any) {
        pool.coloredCubes[11].firstMaterial?.diffuse.contents = colorWell12.color
    }
    
    @IBAction func resetBtnA(_ sender: Any) {
        scene.reset()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pool = Pool(size: 6000, cubeSize: 1, colors: [colorWell1.color,
                                                           colorWell2.color,
                                                           colorWell3.color,
                                                           colorWell4.color,
                                                           colorWell5.color,
                                                           colorWell6.color,
                                                           colorWell7.color,
                                                           colorWell8.color,
                                                           colorWell9.color,
                                                           colorWell10.color,
                                                           colorWell11.color,
                                                           colorWell12.color])
        self.scene = GameScene(pool: pool)
        
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
            if let cell = result.node as? Cell {
                cell.isAlive = !cell.isAlive
            }
        }
    }
}
