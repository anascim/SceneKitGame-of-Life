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
    let pool = Pool(size: 20000, cubeSize: 1)
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
        cameraNode.position = SCNVector3(x: 0, y: 100, z: 10)
        cameraNode.look(at: SCNVector3(x: 0, y: 0, z: 0))
    
        // create and add a light to the scene
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 30, z: 0)
        self.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = NSColor.darkGray
        self.rootNode.addChildNode(ambientLightNode)
        
        #if true
        for row in lastGrid.cells {
            for c in row {
                c.isAlive = true
            }
        }
        #endif
        
        #if false
        lastGrid.cells[5][5].isAlive = true
        lastGrid.cells[6][5].isAlive = true
        lastGrid.cells[6][6].isAlive = true
        lastGrid.cells[7][6].isAlive = true
        lastGrid.cells[6][7].isAlive = true
        
        lastGrid.cells[0][0].isAlive = true
        lastGrid.cells[9][0].isAlive = true
        lastGrid.cells[0][9].isAlive = true
        lastGrid.cells[9][9].isAlive = true
        #endif
        
        renderGrid(grid: lastGrid, y: 0)
    }
    
    func renderGrid(grid: Grid, y: CGFloat) {

    // create cubes
        for row in 0..<grid.rows {
            for col in 0..<grid.cols {
                if grid.cells[row][col].isAlive {
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
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        Time.currentTime = time
        if !self.running { return }
        if nextTime < time {
            self.step()
            nextTime = time + interval
        }
    }
    
    func step() {
        GameOfLife.nextStep(grid: &self.lastGrid)
        Grid.count += 1
        renderGrid(grid: lastGrid, y: CGFloat(Grid.count))
    }
}
