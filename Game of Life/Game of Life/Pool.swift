//
//  Pool.swift
//  Game of Life
//
//  Created by Alex Nascimento on 01/11/19.
//  Copyright © 2019 Alex Nascimento. All rights reserved.
//

import Foundation
import SceneKit

class Pool {
    
    var cubes = [SCNNode]()
    var size: Int = 0
    var pointer: Int = 0 {
        didSet {
            if pointer == size {
                pointer = 0
            }
        }
    }
    let cubeSize: CGFloat
    
    
    init(size: Int, cubeSize: CGFloat) {
        self.size = size
        self.cubeSize = cubeSize
        for _ in 0..<size {
            self.cubes.append(SCNNode(geometry: SCNBox(width: cubeSize, height: cubeSize, length: cubeSize, chamferRadius: 0)))
        }
    }
    
    func getAvailableCube() -> SCNNode {
        let cube = self.cubes[pointer]
        cube.removeFromParentNode()
        self.pointer += 1
        cube.geometry?.firstMaterial?.diffuse.contents = CGColor(red: CGFloat(Time.timeSin), green: 0.0, blue: 0.7, alpha: 1.0)
        return cube
    }
}
