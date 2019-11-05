//
//  GameOfLife.swift
//  Game of Life
//
//  Created by Alex Nascimento on 31/10/19.
//  Copyright © 2019 Alex Nascimento. All rights reserved.
//

import Foundation
import SceneKit

class GameOfLife {
    
    static func nextStep(grid: Grid) -> Grid {
        var states = [Int]()
        var newGrid = Grid(width: grid.cols, height: grid.rows)
        for row in grid.cells {
            for cell in row {
                let cellsAround = grid.getCellsAround(cell: cell)
                
                var count = 0
                for c in cellsAround {
                    if c.state == 1 { count += 1 }
                }
                
                if cell.state == 1 {
                    if count < 2 || count > 3 {
                        states.append(0)
                    } else {
                        states.append(1)
                    }
                } else {
                    if count == 3 {
                        states.append(1)
                    } else {
                        states.append(0)
                    }
                }
            }
        }
        for i in 0..<grid.cellCount {
            if let cell = newGrid.getCell(id: i) {
                cell.state = states[i]
            }
        }
        return newGrid
    }
}
