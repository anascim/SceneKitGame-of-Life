//
//  Pool.swift
//  Game of Life
//
//  Created by Alex Nascimento on 01/11/19.
//  Copyright © 2019 Alex Nascimento. All rights reserved.
//

import Foundation
import SceneKit
import SwiftUI

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
    let cubeGeometry: SCNBox
    var coloredCubes: [SCNBox]
    
    init(size: Int, cubeSize: CGFloat) {
        self.size = size
        self.cubeSize = cubeSize
        self.cubeGeometry = SCNBox(width: cubeSize, height: cubeSize, length: cubeSize, chamferRadius: 0)
        self.coloredCubes = [SCNBox]()
        for _ in 0..<size {
            self.cubes.append(SCNNode(geometry: self.cubeGeometry))
        }
        
        let coloredN: Int = 64
        for i in 0..<coloredN {
            let colorNormalized = CGFloat(i)/CGFloat(coloredN)
            let copy = SCNBox(width: cubeSize, height: cubeSize, length: cubeSize, chamferRadius: 0)
            copy.firstMaterial?.diffuse.contents = NSColor(calibratedHue: colorNormalized, saturation: 1, brightness: 1, alpha: 1)
            self.coloredCubes.append(copy as! SCNBox)
        }
    }
    
    func getAvailableCube() -> SCNNode {
        let cube = self.cubes[pointer]
        cube.removeFromParentNode()
        self.pointer += 1
        return cube
    }
}
