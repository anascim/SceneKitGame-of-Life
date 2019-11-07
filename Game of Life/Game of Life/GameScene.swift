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
    let pool: Pool
    var grid = Grid(width: 50, height: 50)
    var running = false {
        didSet {
            if running {
                self.nextTime = 0
                hideTouchGrid()
            } else {
                showTouchGrid()
            }
        }
    }
    
    var initCameraPos = SCNVector3(0, 0, 0)
    var initLightNodePos = SCNVector3(0, 0, 0)
    var initGridPos = SCNVector3(0, 0, 0)
    var cameraPositionAnchor = SCNVector3(0, 0, 0)
    var cameraRotationAnchor = simd_quatf(ix: 0, iy: 0, iz: 0, r: 1)
    var sideCameraRotation = simd_quatf(ix: 0, iy: 0, iz: 0, r: 1)
    var upCameraRotation = simd_quatf(angle: 0, axis: SIMD3(x: -1, y: 0, z: 0))
    
    

    
    init(pool: Pool) {
        self.pool = pool
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

        cameraNode.position = SCNVector3(x: 0, y: 20, z: 40)
        initCameraPos = cameraNode.position
        cameraNode.look(at: SCNVector3(x: 0, y: 0, z: 15))
        sideCameraRotation = cameraNode.simdOrientation
    
        // create and add a light to the scene
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 30, z: 0)
        initLightNodePos = lightNode.position
        self.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = NSColor.darkGray
        self.rootNode.addChildNode(ambientLightNode)
        
        initGridPos = grid.position
        showTouchGrid()
    }
    
    func showTouchGrid() {
        self.rootNode.addChildNode(grid)
    }
    
    func hideTouchGrid() {
        grid.removeFromParentNode()
    }
    
    var renderCount: Int = 0
    func renderGrid(grid: Grid) {
        var cubes = [SCNNode]()
        for row in 0..<grid.rows {
            for col in 0..<grid.cols {
                if grid.cells[row][col].isAlive {
                    let cube = pool.getAvailableCube()
                    cube.position = grid.cells[row][col].worldPosition
                    cubes.append(cube)
                    self.rootNode.addChildNode(cube)
                }
            }
        }
        for c in cubes {
            c.geometry = pool.coloredCubes[renderCount % pool.coloredCubes.count]
        }
        renderCount += 1
    }
    
    func spaceKey() {
        if running {
            running = false
        }
        self.step()
    }
    
    func enterKey() {
        self.running = !self.running
    }
    
    func reset() {
        pool.removeNodes()
        grid.killCells()
        grid.position = initGridPos
        cameraNode.position = initCameraPos
        lightNode.position = initLightNodePos
        running = false
    }
    
    var interval: TimeInterval = 0.05
    var nextTime: TimeInterval = 0
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        Time.currentTime = time
        cameraPositionAnchor = SCNVector3(x: initCameraPos.x, y: self.grid.position.y + initCameraPos.y, z: initCameraPos.z)
//        if running {
//            cameraPositionAnchor = SCNVector3(x: initCameraPos.x, y: self.grid.position.y + initCameraPos.y, z: initCameraPos.z)
////            cameraRotationAnchor = sideCameraRotation
//        } else {
//            cameraPositionAnchor = SCNVector3(x: grid.position.x, y: self.grid.position.y + 50, z: grid.position.z)
////            cameraRotationAnchor = upCameraRotation
//        }
        cameraNode.position = lerp(from: cameraNode.position, to: cameraPositionAnchor, pct: 0.05)
//        cameraNode.simdOrientation = simd_slerp(cameraNode.simdOrientation, cameraRotationAnchor, 0.001)
        if !self.running { return }
        if nextTime < time {
            self.step()
            nextTime = time + interval
        }
    }
    
    func step() {
        GameOfLife.nextStep(grid: &self.grid)
        grid.position.y += 1
        lightNode.position.y += 1
        ambientLightNode.position.y += 1
        renderGrid(grid: grid)
    }
    
    func lerp(from: SCNVector3, to: SCNVector3, pct: CGFloat) -> SCNVector3 {
        if pct > 1 { return to }
        if pct < 0 { return from }
        let x: CGFloat = from.x*(1-pct) + to.x*pct
        let y: CGFloat = from.y*(1-pct) + to.y*pct
        let z: CGFloat = from.z*(1-pct) + to.z*pct
        return SCNVector3(x: x, y: y, z: z)
    }
    
    func lerp(from: CGFloat, to: CGFloat, pct: CGFloat) -> CGFloat {
        if pct > 1 { return to }
        if pct < 0 { return from }
        return from*(1-pct) + to*pct
    }
}
