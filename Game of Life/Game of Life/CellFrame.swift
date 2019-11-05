//
//  CellFrame.swift
//  Game of Life
//
//  Created by Alex Nascimento on 01/11/19.
//  Copyright © 2019 Alex Nascimento. All rights reserved.
//

import Foundation
import SceneKit

class CellFrame : SCNNode {
    
    var cubes = [SCNNode]() {
        didSet {
            if cubes.count == 0 {
                self.removeFromParentNode()
            }
        }
    }
    
    init(grid: Grid, y: CGFloat, pool: Pool) {
        super.init()
        self.position.x = 10//CGFloat(grid.cols)/2
        self.position.z = 10//-CGFloat(grid.rows)/2
        // create cubes
        for row in 0..<grid.rows {
            for col in 0..<grid.cols {
                if grid.cells[row][col].state == 1 {
                    let cube = pool.getAvailableCube()
                    cube.position.x = -CGFloat(col)
                    cube.position.z = -CGFloat(row)
                    cube.position.y = y
                    cube.geometry?.firstMaterial?.diffuse.contents = CGColor.white
                    cubes.append(cube)
                    self.addChildNode(cube)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
