//
//  Ekipage.swift
//  ParseStarterProject-Swift
//
//  Created by Christian Barlöf on 2016-01-14.
//  Copyright © 2016 Parse. All rights reserved.
//

//import UIKit
import Foundation

class Ekipage: NSObject {
    
    var Namn:   String?
    var Hund:   String?
    var Pwd:    String?
    var Plats:  String?
    var Kls0Po: Int = 0
    var Kls0Di: Int = 0
    var Kls1Po: Int = 0
    var Kls1Di: Int = 0
    var Kls2Po: Int = 0
    var Kls2Di: Int = 0
    var Kls3Po: Int = 0
    var Kls3Di: Int = 0
    var TotDi:  Int = 0
    var TotSt:  Int = 0

    override init() {
//        super.init()
    }
    
// Initialize stored properties.
    init(Namn: String, Hund: String, Pwd: String, Plats: String, Kls0Po: Int, Kls1Po: Int, Kls2Po: Int, Kls3Po: Int, Kls0Di: Int, Kls1Di: Int, Kls2Di: Int, Kls3Di: Int, TotDi: Int, TotSt: Int) {
       
        self.Namn   = Namn
        self.Hund   = Hund
        self.Pwd    = Pwd
        self.Plats  = Plats
        self.Kls0Po = Kls0Po
        self.Kls0Di = Kls0Di
        self.Kls1Po = Kls1Po
        self.Kls2Po = Kls2Po
        self.Kls3Po = Kls3Po
        self.Kls1Di = Kls1Di
        self.Kls2Di = Kls2Di
        self.Kls3Di = Kls3Di
        self.TotDi  = TotDi
        self.TotSt  = TotSt

// Initialization should fail if there is no name or if the rating is negative.
        if Kls1Po == 10 || Kls1Di < 0 {
            //return nil
        }
    }
}

        
        

