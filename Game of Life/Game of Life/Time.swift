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
}
