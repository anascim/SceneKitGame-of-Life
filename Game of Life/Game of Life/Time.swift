//
//  Time.swift
//  Game of Life
//
//  Created by Alex Nascimento on 05/11/19.
//  Copyright © 2019 Alex Nascimento. All rights reserved.
//

import Foundation

class Time {
    
    static var currentTime: TimeInterval = 0
    static var timeSin: TimeInterval {
        return sin(currentTime)
    }
    static var timeCos: TimeInterval {
        return cos(currentTime)
    }
    static var normSin: CGFloat {
        return CGFloat(timeSin/2 + 0.5)
    }
    static var normCos: CGFloat {
        return CGFloat(timeCos/2 + 0.5)
    }
}
