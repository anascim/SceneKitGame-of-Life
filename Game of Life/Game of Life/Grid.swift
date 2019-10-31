//
//  Grid.swift
//  Game of Life
//
//  Created by Alex Nascimento on 31/10/19.
//  Copyright © 2019 Alex Nascimento. All rights reserved.
//

import Foundation
import SceneKit

class Grid : SCNNode {
    
    var cells = [[Cell]]()
    var cellCount: Int {
        return rows*cols
    }
    var aspect: (Int, Int)
    var rows: Int {
        return aspect.1
    }
    var cols: Int {
        return aspect.0
    }
    var cellSize: CGFloat
    
    init(width: Int, height: Int) {
        self.aspect = (width, height)
        self.cellSize = 1
        super.init()
        createCells()
        self.position.x = CGFloat(width)/2 * cellSize
        self.position.z = CGFloat(height)/2 * cellSize
    }
    
    func createCells() {
        for i in 0..<rows {
            var row = [Cell]()
            for j in 0..<cols {
                let cell = Cell(id: i * cols + j, x: j, y: i, cubeSize: cellSize)
                row.append(cell)
                self.addChildNode(cell)
            }
//            var str: String = ""
//            for c in row {
//                str.append("\(c.id) ")
//            }
//            print(str)
            cells.append(row)
        }
    }
    
    func getCell(id: Int) -> Cell? {
        if id >= cellCount || id < 0 { return nil }
        
        let row = id / cols
        let col = id % cols
        
        return cells[row][col]
    }
    
    func getCell(col: Int, row: Int) -> Cell? {
        if col >= cols || col < 0 || row >= rows || row < 0 {
            return nil
        }
        return cells[row][col]
    }
    
    func getCellsAround(cell: Cell) -> [Cell] {
        var cells = [Cell]()
        if let c = getCell(col: cell.col + 1, row: cell.row) {
            cells.append(c)
        }
        if let c = getCell(col: cell.col + 1, row: cell.row + 1) {
            cells.append(c)
        }
        if let c = getCell(col: cell.col, row: cell.row + 1) {
            cells.append(c)
        }
        if let c = getCell(col: cell.col - 1, row: cell.row + 1) {
            cells.append(c)
        }
        if let c = getCell(col: cell.col - 1, row: cell.row) {
            cells.append(c)
        }
        if let c = getCell(col: cell.col - 1, row: cell.row - 1) {
            cells.append(c)
        }
        if let c = getCell(col: cell.col, row: cell.row - 1) {
            cells.append(c)
        }
        if let c = getCell(col: cell.col + 1, row: cell.row - 1) {
            cells.append(c)
        }
        return cells
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
