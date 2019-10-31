//
//  Cell.swift
//  Game of Life
//
//  Created by Alex Nascimento on 31/10/19.
//  Copyright © 2019 Alex Nascimento. All rights reserved.
//

import Foundation
import SceneKit

class Cell : SCNNode {
    
    let id: Int
    let coord: (Int, Int) //(x/col, y/row)
    var row: Int {
        return coord.1
    }
    var col: Int {
        return coord.0
    }
    var state: Int { // 0 dead, 1 alive
        didSet {
            if state == 0 {
                self.geometry!.firstMaterial?.diffuse.contents = deadColor
            } else {
                self.geometry!.firstMaterial?.diffuse.contents = aliveColor
            }
        }
    }
    let aliveColor: CGColor = .white
    let deadColor: CGColor = .black
    
    init(id: Int, x: Int, y: Int, cubeSize: CGFloat) {
        self.id = id
        self.coord = (x, y)
        self.state = 0
        super.init()
        self.geometry = SCNBox(width: cubeSize, height: cubeSize, length: cubeSize, chamferRadius: 0)
        self.geometry!.firstMaterial?.diffuse.contents = deadColor
        self.position = SCNVector3(CGFloat(col) * -cubeSize, 0, CGFloat(row) * -cubeSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
