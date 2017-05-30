    //
//  Barometer.swift
//  ParseStarterProject-Swift
//
//  Created by Christian Barlöf on 2016-01-13.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation
import UIKit
import Parse

var HighScore: Int = 0
var HighDisc: Int = 0
var x_scale: Float = 0
var d_scale: Float = 0
var prc_scale: Float = 0
var password_chb: Int = 0
    
let kl0col = UIColor(red: (0xFF)/255, green: (0xCC)/255, blue: (0xFF)/255, alpha: 1.0)
let kl1col = UIColor(red: (0xFF)/255, green: 99/255,     blue: (0xCC)/255, alpha: 1.0)
let kl2col = UIColor(red: (0xFF)/255, green: 0/255,      blue: (0xCC)/255, alpha: 1.0)
let kl3col = UIColor(red: (0xCC)/255, green: 0/255,      blue: (0xFF)/255, alpha: 1.0)
let discol = UIColor(red: (0xFF)/255, green: 0/255,      blue: 66/255, alpha: 1.0)

class Barometer:  UIViewController, UITableViewDelegate, UITableViewDataSource, HomeModelProtocal {

// OUTLET
    @IBOutlet var TableView: UITableView!
    
// CONSTANTS
    let cnst_Po  = "Poäng"
    let cnst_Po0 = "Po-Ö"
    let cnst_Po1 = "Po-1"
    let cnst_Po2 = "Po-2"
    let cnst_Po3 = "Po-3"
    let cnst_Di  = "Disk"
    
// VARIABLES
    var feedItems: NSArray = NSArray()
    var Str_ekipage = Ekipage(Namn: "", Hund: "", Pwd: "", Plats: "", Kls0Po: 0, Kls1Po: 0, Kls2Po: 0, Kls3Po: 0, Kls0Di: 0, Kls1Di: 0, Kls2Di: 0, Kls3Di: 0, TotDi: 0, TotSt: 0)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadEkip_Sebac()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEkip_Sebac()
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
    }
    
// FUNCTIONS
    func loadEkip_Sebac() {
        
// Set delegates and initialize homeModel
        self.TableView.delegate = self
        self.TableView.dataSource = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
    }
    
    func itemsDownloaded(_ items: NSArray) {
        
        feedItems = items
        self.TableView.reloadData()
    }


    func numberOfSections(in tableView: UITableView) -> Int {
// #warning Incomplete implementation, return the number of sections
       return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
// #warning Incomplete implementation, return the number of rows
        return feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "EkipageCell", for: indexPath) as! Ekipage_det
        var amt_class: Int = 0
        var perc_disc: Int = 0
        Str_ekipage = feedItems[indexPath.row] as! Ekipage

        cell.Forare.text    = Str_ekipage.Namn
        cell.Hund.text      = Str_ekipage.Hund
        cell.Lab_1.text              = ""
        cell.View_1.frame.size.width = 0
        cell.Txt_1.text              = ""
        cell.Lab_2.text              = ""
        cell.View_2.frame.size.width = 0
        cell.Txt_2.text              = ""
        cell.Lab_3.text              = ""
        cell.View_3.frame.size.width = 0
        cell.Txt_3.text              = ""
        cell.Lab_4.text              = ""
        cell.View_4.frame.size.width = 0
        cell.Txt_4.text              = ""
        
        if (Str_ekipage.Kls0Po > 0) {
            cell.Lab_1.text = cnst_Po
            cell.View_1.frame.size.width = (CGFloat(Float(Str_ekipage.Kls0Po) * x_scale))
            cell.Txt_1.text = String(Str_ekipage.Kls0Po)
            cell.View_1.backgroundColor = kl0col
            amt_class += 1
        }

        if (Str_ekipage.Kls1Po > 0) {
            switch amt_class {
            case 0:
                cell.Lab_1.text = cnst_Po
                cell.View_1.frame.size.width = (CGFloat(Float(Str_ekipage.Kls1Po) * x_scale))
                cell.Txt_1.text = String(Str_ekipage.Kls1Po)
                cell.View_1.backgroundColor = kl1col
            case 1:
                cell.Lab_2.text = cnst_Po
                cell.View_2.frame.size.width = (CGFloat(Float(Str_ekipage.Kls1Po) * x_scale))
                cell.Txt_2.text = String(Str_ekipage.Kls1Po)
                cell.View_2.backgroundColor = kl1col
                
            default:
                amt_class += 0
            }
            amt_class += 1
        }
        
        if (Str_ekipage.Kls2Po > 0) {
            switch amt_class {
            case 0:
                cell.Lab_1.text = cnst_Po
                cell.View_1.frame.size.width = (CGFloat(Float(Str_ekipage.Kls2Po) * x_scale))
                cell.Txt_1.text = String(Str_ekipage.Kls2Po)
                cell.View_1.backgroundColor = kl2col
            case 1:
                cell.Lab_2.text = cnst_Po
                cell.View_2.frame.size.width = (CGFloat(Float(Str_ekipage.Kls2Po) * x_scale))
                cell.Txt_2.text = String(Str_ekipage.Kls2Po)
                cell.View_2.backgroundColor = kl2col
            case 2:
                cell.Lab_3.text = cnst_Po
                cell.View_3.frame.size.width = (CGFloat(Float(Str_ekipage.Kls2Po) * x_scale))
                cell.Txt_3.text = String(Str_ekipage.Kls2Po)
                cell.View_3.backgroundColor = kl2col
            default:
                amt_class += 0
            }
            amt_class += 1
        }

        if (Str_ekipage.Kls3Po > 0) {
            switch amt_class {
            case 0:
                cell.Lab_1.text = cnst_Po
                cell.View_1.frame.size.width = (CGFloat(Float(Str_ekipage.Kls3Po) * x_scale))
                cell.Txt_1.text = String(Str_ekipage.Kls3Po)
                cell.View_1.backgroundColor = kl3col
            case 1:
                cell.Lab_2.text = cnst_Po
                cell.View_2.frame.size.width = (CGFloat(Float(Str_ekipage.Kls3Po) * x_scale))
                cell.Txt_2.text = String(Str_ekipage.Kls3Po)
                cell.View_2.backgroundColor = kl3col
            case 2:
                cell.Lab_3.text = cnst_Po
                cell.View_3.frame.size.width = (CGFloat(Float(Str_ekipage.Kls3Po) * x_scale))
                cell.Txt_3.text = String(Str_ekipage.Kls3Po)
                cell.View_3.backgroundColor = kl3col
            default:
                amt_class += 0
            }
            amt_class += 1
        }
        

        if (Str_ekipage.TotDi > 0) {
            switch amt_class {
            case 0:

// Disc-Percent
                if Str_ekipage.TotSt > 0 {
                    cell.Lab_1.text = cnst_Di
                    perc_disc = (Str_ekipage.TotDi * 200 + Str_ekipage.TotSt)/(2 * Str_ekipage.TotSt)
                    cell.View_1.frame.size.width = (CGFloat(Float(perc_disc) * prc_scale))
                    cell.Txt_1.text = (String(perc_disc) + "%")
                    cell.View_1.backgroundColor = discol
                }
            case 1:
// Disc-Percent
                if Str_ekipage.TotSt > 0 {
                    cell.Lab_2.text = cnst_Di
                    perc_disc = (Str_ekipage.TotDi * 200 + Str_ekipage.TotSt)/(2 * Str_ekipage.TotSt)
                    cell.View_2.frame.size.width = (CGFloat(Float(perc_disc) * prc_scale))
                    cell.Txt_2.text = (String(perc_disc) + "%")
                    cell.View_2.backgroundColor = discol
                }
            case 2:
// Disc-Percent
                if Str_ekipage.TotSt > 0 {
                    cell.Lab_3.text = cnst_Di
                    perc_disc = (Str_ekipage.TotDi * 200 + Str_ekipage.TotSt)/(2 * Str_ekipage.TotSt)
                    cell.View_3.frame.size.width = (CGFloat(Float(perc_disc) * prc_scale))
                    cell.Txt_3.text = (String(perc_disc) + "%")
                    cell.View_3.backgroundColor = discol
                }
            case 3:
                if Str_ekipage.TotSt > 0 {
                    cell.Lab_4.text = cnst_Di
                    perc_disc = (Str_ekipage.TotDi * 200 + Str_ekipage.TotSt)/(2 * Str_ekipage.TotSt)
                    cell.View_4.frame.size.width = (CGFloat(Float(perc_disc) * prc_scale))
                    cell.Txt_4.text = (String(perc_disc) + "%")
                    cell.View_4.backgroundColor = discol
                }
            default:
                amt_class += 0
            }
        }

        tableView.rowHeight = 50
        
    
// Configure the cell...
        return cell
    }
}
