//
//  Pickview.swift
//  SBK-Barometer
//
//  Created by Christian Barlöf on 2017-03-21.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation

class Pickview: NSObject {
    
    var Value: String?
    
    override init() {
        //        super.init()
    }

    init(Value: String) {
 
        self.Value   = Value
   
    }
}
