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
    
    static var cubeGeometry = SCNBox(width: 0.9, height: 0.9, length: 0.9, chamferRadius: 0.05)
    static var aliveGeometry = SCNBox(width: 0.9, height: 0.9, length: 0.9, chamferRadius: 0.05)
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
    
    init(width: Int, height: Int) {
        self.aspect = (width, height)
        
        super.init()
        for row in 0..<height {
            var cellRow = [Cell]()
            for col in 0..<width {
                let cell = Cell(id: row * self.cols + col, x: col, y: row, alive: false)
                cell.position = SCNVector3(CGFloat(col), 0, CGFloat(row))
                cellRow.append(cell)
                self.addChildNode(cell)
            }
            self.cells.append(cellRow)
        }
        self.position.x = -CGFloat(self.cols)/2 + 0.5
        self.position.z = -CGFloat(self.rows)/2 + 0.5
        Grid.cubeGeometry.firstMaterial?.diffuse.contents = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2)
        Grid.aliveGeometry.firstMaterial?.diffuse.contents = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        Grid.aliveGeometry.firstMaterial?.emission.contents = CGColor.white
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
    
    func killCells() {
        for row in cells {
            for c in row {
                c.isAlive = false
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
