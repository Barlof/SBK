//
//  Barometer_det.swift
//  Ekipage_det.swift
//  ParseStarterProject-Swift
//
//  Created by Christian Barlöf on 2016-01-13.
//  Copyright © 2016 Parse. All rights reserved.

import UIKit
import Parse

class Ekipage_det: UITableViewCell {
    
    @IBOutlet weak var Forare: UILabel!
    @IBOutlet weak var Hund: UILabel!
    
    @IBOutlet weak var Lab_1: UILabel!
    @IBOutlet weak var View_1: UIView!
    @IBOutlet weak var Txt_1: UILabel!
    
    @IBOutlet weak var Lab_2: UILabel!
    @IBOutlet weak var Txt_2: UILabel!
    @IBOutlet weak var View_2: UIView!
    
    @IBOutlet weak var Lab_3: UILabel!
    @IBOutlet weak var View_3: UIView!
    @IBOutlet weak var Txt_3: UILabel!
    
    @IBOutlet weak var Lab_4: UILabel!
    @IBOutlet weak var View_4: UIView!
    @IBOutlet weak var Txt_4: UILabel!

    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    func setBarSize()
    {

    }

}

