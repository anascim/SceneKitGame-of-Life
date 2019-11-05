//
//  GameScene.swift
//  Game of Life
//
//  Created by Alex Nascimento on 02/11/19.
//  Copyright © 2019 Alex Nascimento. All rights reserved.
//

import Foundation
import SceneKit

class GameScene : SCNScene, SCNSceneRendererDelegate {
    
    let cameraNode = SCNNode()
    let lightNode = SCNNode()
    let ambientLightNode = SCNNode()
    let pool = Pool(size: 1000, cubeSize: 1)
    var lastGrid = Grid(width: 100, height: 100)
    var running = false
    
    override init() {
        super.init()
        self.setupScene()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupScene() {
        // create and add a camera to the scene
        cameraNode.camera = SCNCamera()
        cameraNode.camera!.zFar = 500
        self.rootNode.addChildNode(cameraNode)

        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 30, z: 40)
        cameraNode.look(at: SCNVector3(x: 0, y: 0, z: 5))
    
        // create and add a light to the scene
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        self.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = NSColor.darkGray
        self.rootNode.addChildNode(ambientLightNode)
        
        lastGrid = Grid(width: 50, height: 50)

//        for row in 0..<lastGrid.cells.count {
//            for col in 0..<lastGrid.cells[0].count {
//                lastGrid.cells[row][col].state = 1
//            }
//        }
        lastGrid.cells[25][25].state = 1
        lastGrid.cells[26][25].state = 1
        lastGrid.cells[26][26].state = 1
        lastGrid.cells[27][26].state = 1
        lastGrid.cells[26][27].state = 1
        
        lastGrid.cells[0][0].state = 1
        lastGrid.cells[49][0].state = 1
        lastGrid.cells[0][49].state = 1
        lastGrid.cells[49][49].state = 1
        
        renderGrid(grid: lastGrid, y: 0)
    }
    
    func renderGrid(grid: Grid, y: CGFloat) {


    // create cubes
        for row in 0..<grid.rows {
            for col in 0..<grid.cols {
                if grid.cells[row][col].state == 1 {
                    let cube = pool.getAvailableCube()
                    cube.position.x = -CGFloat(col) + CGFloat(grid.cols)/2 - 0.5
                    cube.position.z = -CGFloat(row) + CGFloat(grid.rows)/2 - 0.5
                    cube.position.y = y
                    cube.geometry?.firstMaterial?.diffuse.contents = CGColor.white
                    self.rootNode.addChildNode(cube)
                }
            }
        }
    }
    
    func spaceKey() {
        self.step()
    }
    
    func enterKey() {
        self.running = !self.running
    }
    
    let interval: TimeInterval = 0.01
    var nextTime: TimeInterval = 0
    var deltaTime: TimeInterval = 0
    var lastTime: TimeInterval = 0
    var count: Int = 0
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if !self.running { return }
        if nextTime < time {
            cameraNode.position.y += 1
            ambientLightNode.position.y += 1
            lightNode.position.y += 1
            self.step()
            nextTime = time + interval
        }
        lastTime = time
    }
    
    func step() {
        lastGrid = GameOfLife.nextStep(grid: self.lastGrid)
        renderGrid(grid: lastGrid, y: CGFloat(Grid.count))
    }
}
