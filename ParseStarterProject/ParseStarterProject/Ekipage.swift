//
//  Ekipage.swift
//  ParseStarterProject-Swift
//
//  Created by Christian Barlöf on 2016-01-14.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class Ekipage {
    
    var Namn:   String
    var Hund:   String
    var Klass1: Int = 0
    var Klass2: Int = 0
    var Klass3: Int = 0
    var Disk:   Int = 0
    
    init(Namn: String, Hund: String, Klass1: Int, Klass2: Int, Klass3: Int, Disk: Int) {
        // Initialize stored properties.
        self.Namn   = Namn
        self.Hund   = Hund
        self.Klass1 = Klass1
        self.Klass2 = Klass2
        self.Klass3 = Klass3
        self.Disk   = Disk
        
        // Initialization should fail if there is no name or if the rating is negative.
        if Klass1 == 10 || Disk < 0 {
            //return nil
        }
    }
}

        
        

