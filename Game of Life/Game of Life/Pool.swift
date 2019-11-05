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
        return cube
    }
}
//
//struct Cube {
//    var index: Int
//    var cube: SCNNode
//    var isActive = false
//
//    init(index: Int) {
//        self.index = index
//        self.cube = SCNNode(geometry: SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0))
//    }
//}
