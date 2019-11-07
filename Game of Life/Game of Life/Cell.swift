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
    var isAlive: Bool {
        didSet {
            if isAlive {
                self.geometry = Grid.aliveGeometry
            } else {
                self.geometry = Grid.cubeGeometry
            }
        }
    }
    
    var neighboursAlive: UInt8
    
    init(id: Int, x: Int, y: Int, alive: Bool) {
        self.id = id
        self.coord = (x, y)
        self.isAlive = alive
        self.neighboursAlive = 0
        super.init()
        self.geometry = Grid.cubeGeometry
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

