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
    
    static func nextStep(grid: inout Grid) {
        
        var cellsToCheck = Set<Cell>()
        
        for row in grid.cells {
            for cell in row {
                if cell.isAlive {
                    let cellsAround = grid.getCellsAround(cell: cell)
                    cellsAround.forEach { $0.neighboursAlive += 1 }
                    cellsToCheck = cellsToCheck.union(cellsAround)
                    cellsToCheck.insert(cell)
                }
            }
        }
        
        var cellsToChange = [Cell]()

        for cell in cellsToCheck {
            if cell.isAlive {
                if cell.neighboursAlive < 2 || cell.neighboursAlive > 3 {
                    cellsToChange.append(cell)
                }
            } else {
                if cell.neighboursAlive == 3 {
                    cellsToChange.append(cell)
                }
            }
            cell.neighboursAlive = 0
        }
        
        for cell in cellsToChange {
            cell.isAlive = !cell.isAlive
        }
    }
}
