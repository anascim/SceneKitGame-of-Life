//
//  Cell.swift
//  Game of Life
//
//  Created by Alex Nascimento on 31/10/19.
//  Copyright © 2019 Alex Nascimento. All rights reserved.
//

import Foundation
import SceneKit

class Cell {
    
    let id: Int
    let coord: (Int, Int) //(x/col, y/row)
    var row: Int {
        return coord.1
    }
    var col: Int {
        return coord.0
    }
    var state: Int
    
    init(id: Int, x: Int, y: Int, state: Int) {
        self.id = id
        self.coord = (x, y)
        self.state = state
//        super.init()
//        self.geometry = SCNBox(width: cubeSize, height: cubeSize, length: cubeSize, chamferRadius: 0)
//        self.geometry!.firstMaterial?.diffuse.contents = deadColor
//        self.position = SCNVector3(CGFloat(col) * -cubeSize, 0, CGFloat(row) * -cubeSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Cell : Equatable {
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Cell : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(coord.0)
        hasher.combine(coord.1)
    }
}

