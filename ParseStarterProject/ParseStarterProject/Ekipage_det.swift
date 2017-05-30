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
//class Barometer_det: UITableViewCell {

    @IBOutlet weak var Stapel_1: UIView!
    @IBOutlet weak var Stapel_2: UIView!
    @IBOutlet weak var Stapel_3: UIView!
    @IBOutlet weak var Stapel_4: UIView!

    @IBOutlet weak var Forare: UILabel!
    @IBOutlet weak var Hund: UILabel!
    
    @IBOutlet weak var TableView: UITableView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setBarSize()
    {

    }

}

