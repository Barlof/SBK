//
//  Password.swift
//  SBK-Barometer
//
//  Created by Christian Barlöf on 2017-05-06.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation

class Password: NSObject {
    
    var Namn:  String?
    var Pwd:   String?
    
    override init() {
        //        super.init()
    }
    
    // Initialize stored properties.
    init(Namn: String, Pwd: String) {
        
        self.Namn   = Namn
        self.Pwd    = Pwd
        
        // Initialization should fail if there is no name or if the rating is negative.
//        if Kls1Po == 10 || Kls1Di < 0 {
//          return nil
//        }
    }
}
