//
//  Barometer.swift
//  ParseStarterProject-Swift
//
//  Created by Christian Barlöf on 2016-01-13.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

    var Gbl_Str_ekipage = Ekipage(Namn: "", Hund: "", Klass1: 0, Klass2: 0, Klass3: 0, Disk: 0)
    var Gbl_Tab_ekipage = [Gbl_Str_ekipage]

class Barometer:  UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var TableView: UITableView!

    var Str_ekipage = Ekipage(Namn: "", Hund: "", Klass1: 0, Klass2: 0, Klass3: 0, Disk: 0)
    var Tab_ekipage = [Ekipage]()
    
    var ekipage = Ekipage(Namn: "", Hund: "", Klass1: 0, Klass2: 0, Klass3: 0, Disk: 0)
    var ekipages = [Ekipage]()

    var Parse_plac  = Int()
    var PlacPoang = Int()

    var Klass1   = 0
    var Klass2   = 0
    var Klass3   = 0
    var Disk_cnt = 0
    var disk: Bool?
    var Gren: String?
    var Name = ""
    var Hund: String?
    var Klass: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEkip4()
//        let int = self.ekipages.count
//        var index = 0
//        if int > 0 {
//            repeat{
//                Gbl_Tab_ekipage[index] = self.ekipages[index]
//                index = index + 1
//            } while index < int
            
//        }

    }

    func loadEkip4() {
        Disk_cnt == 0
        let query = PFQuery(className: "Barometer_2016")
//        let query = PFQuery(className: "TestObject")
        query.orderByAscending("Forare")
        query.addAscendingOrder("Hund")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            for row in objects! {
                if(self.Name == "")
                {
                    self.Name     = row.valueForKey("Forare") as! String
                    self.Hund     = (row.valueForKey("Hund") as! String)
                    self.Klass1   = 0
                    self.Klass2   = 0
                    self.Klass3   = 0
                    self.Disk_cnt = 0
                }
                
                if (self.Name != (row.valueForKey("Forare") as! String) || self.Hund != (row.valueForKey("Hund") as! String))
                {
                    self.Str_ekipage = self.ekipage
                    self.Tab_ekipage.append(self.Str_ekipage)
                
                    self.Name     = row.valueForKey("Forare") as! String
                    self.Hund     = ((row.valueForKey("Hund") as! String))
                    self.Klass1   = 0
                    self.Klass2   = 0
                    self.Klass3   = 0
                    self.Disk_cnt = 0
                }
                self.Klass = (row.valueForKey("Klass") as? NSString) as? String
                self.disk  = (row.valueForKey("Disk") as? Bool)
                self.Gren  = (row.valueForKey("Gren") as? NSString) as? String
                self.PlacPoang = (row.valueForKey("Poang") as? Int)!
                
                if self.disk == true {
                    self.Disk_cnt++
                }
// Hämta Plac-Poäng
                Registrera().PoangBer(self.Gren!, Plac: self.PlacPoang)
            
                switch self.Klass {
                case "Ag: 1-Agility":
                    self.Klass1 = self.Klass1 + self.PlacPoang
                case "Ag: 1-Hopp":
                    self.Klass1 = self.Klass1 + self.PlacPoang
                case "Ag: 2-Agility":
                    self.Klass2 = self.Klass2 + self.PlacPoang
                case "Ag: 2-Hopp":
                    self.Klass2 = self.Klass2 + self.PlacPoang
                case "Ag: 3-Agility":
                    self.Klass3 = self.Klass3 + self.PlacPoang
                case "Ag: 3-Hopp":
                    self.Klass3 = self.Klass3 + self.PlacPoang
                default: break
                }

                self.ekipage =  Ekipage(Namn: self.Name, Hund: self.Hund!, Klass1: self.Klass1, Klass2: self.Klass2, Klass3: self.Klass3, Disk: self.Disk_cnt)
                self.ekipages.append(self.ekipage)
            }
            self.Str_ekipage = self.ekipage
            self.Tab_ekipage.append(self.Str_ekipage)
            
            dispatch_async(dispatch_get_main_queue(),{
                self.TableView.reloadData()
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
//        print("Start/End_ovs:numberOfSectionsInTableView")
        
       return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
//        return GblTab_ekipage.count
        return Tab_ekipage.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCellWithIdentifier("EkipageCell", forIndexPath: indexPath) as! Ekipage_det
        
        
        Str_ekipage = Tab_ekipage[indexPath.row]
        Gbl_Tab_ekipage.append(Str_ekipage)

        cell.Forare.text    = Str_ekipage.Namn
        
//        print(cell.Forare.frame.size.width)
        cell.Hund.text      = Str_ekipage.Hund
//        print("Barometer:cell:Str_ekipage", Str_ekipage.Klass1)
//        print("Barometer:cell:Str_ekipage", Str_ekipage.Klass2)
//        print("Barometer:cell:Str_ekipage", Str_ekipage.Klass3)
            cell.Stapel_1.frame.size.width = CGFloat(Str_ekipage.Klass1 * 4)
            cell.Stapel_2.frame.size.width = CGFloat(Str_ekipage.Klass2 * 4)
            cell.Stapel_3.frame.size.width = CGFloat(Str_ekipage.Klass3 * 4)
            cell.Stapel_4.frame.size.width = CGFloat(Str_ekipage.Disk * 4)
        
// Configure the cell...
        return cell
    }
}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 //   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        if (segue.identifier == "Barometer") {


//            let destinationVC:ViewControllerClass = segue.destinationViewController as! ViewControllerClass
            
            //set properties on the destination view controller
//            destinationVC.name = viewName*/
//            }

//        }
    
//    }

