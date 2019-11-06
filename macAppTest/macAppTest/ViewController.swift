//
//  ViewController.swift
//  macAppTest
//
//  Created by Alex Nascimento on 05/11/19.
//  Copyright © 2019 Alex Nascimento. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var label: NSTextField!
    
    @IBAction func button(_ sender: Any) {
        label.stringValue = "pushed"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

