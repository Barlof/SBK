//
//  Handl_det.swift
//  SBK-Barometer
//
//  Created by Christian Barlöf on 2016-12-12.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation

import UIKit

class Handl_det2: UITableViewCell {
    
//    @IBOutlet weak var txt_Info: UITextView!
    @IBOutlet weak var txt_Reg_Rub: UITextView!
    @IBOutlet weak var txt_Reg: UITextView!
    @IBOutlet weak var txt_Barometer_Rub: UITextView!
    @IBOutlet weak var txt_Barometer: UITextView!
    
    override func awakeFromNib() {
        
        //        super.sizeToFit()
        super.awakeFromNib()
//        txt_Info.contentMode = .scaleToFill
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
}
