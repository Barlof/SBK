//
//  Handledning.swift
//  SBK-Barometer
//
//  Created by Christian Barlöf on 2016-12-12.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation
import UIKit

class Handledning: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.TableView.reloadData()
    
    }

// MARK: - Table view data source
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "HandlCell", for: indexPath) as! Handl_det
        
     
// Configure the cell...
        return cell
    
    }

}
