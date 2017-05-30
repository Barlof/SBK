	//
//  HomeModel.swift
//  SBK-Barometer
//
//  Created by Christian Barlöf on 2016-11-23.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Foundation
   var Arr_Ekipages = [Ekipage]()

protocol HomeModelProtocal: class {
    func itemsDownloaded(_ items: NSArray)
}

class HomeModel: NSObject, URLSessionDataDelegate {
    
// Properties
    weak var delegate: HomeModelProtocal!
    
    var data : NSMutableData = NSMutableData()
    
// Where momservice.php lives
    let urlPath: String = "http://momflytt.se/api/momservice.php"
    
// CONSTANTS
    let cnst_Forare = "Forare"
    let cnst_Hund   = "Hund"
    let cnst_Gren   = "Gren"
    let cnst_Plats  = "Plats"
    let cnst_Klass  = "Klass"
    let cnst_Poang  = "Poang"
    let cnst_Disk   = "Disk"
    let cnst_Ag0Ho  = "Öp-Hopp"
    let cnst_Ag0Ag  = "Öp-Agility"
    let cnst_Ag1Ho  = "Ag1Hopp"
    let cnst_Ag1Ag  = "Ag1Agility"
    let cnst_Ag2Ho  = "Ag2Hopp"
    let cnst_Ag2Ag  = "Ag2Agility"
    let cnst_Ag3Ho  = "Ag3Hopp"
    let cnst_Ag3Ag  = "Ag3Agility"
    let cnst_Ja     = "Ja"

// VARIABLES
    var Arr_Ekipages_lcl = [Ekipage]()
    var jsonResult:  NSMutableArray = NSMutableArray()
    var jsonResult2: NSMutableArray = NSMutableArray()
//    var jsonResult3: NSArray = NSArray()
    var jsonElement: NSDictionary = NSDictionary()

    var forare     = String()
    var hund       = String()
    var pwd        = String()
    var klass      = String()
    var plats      = String()
    
// Klass-Points & Klass-Disc
    var Kls0Po = Int()
    var Kls1Po = Int()
    var Kls2Po = Int()
    var Kls3Po = Int()
    var Kls0Di = Int()
    var Kls1Di = Int()
    var Kls2Di = Int()
    var Kls3Di = Int()
    var antal  = Int()

// Klass-Starts
    var Kls0St = Int()
    var Kls1St = Int()
    var Kls2St = Int()
    var Kls3St = Int()

// FUNCTIONS
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!

        var session: Foundation.URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil)

        let task = session.dataTask(with: url)
        
        task.resume()
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.data.append(data);
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            print("Failed to download data")
        }else {
            print("Data downloadedd(URLSession)")
            self.parseJSON2()
        }
    }

    func parseJSON2() {
        var jsonResult3: NSArray = NSArray()
// Fetch data from dB
        do{

            jsonResult3 = try (JSONSerialization.jsonObject(with: self.data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray)
            jsonResult2 = jsonResult3.mutableCopy() as! NSMutableArray
        } catch let error as NSError {
            print(error)
        }
        
// Sort Result
        let js_for = NSSortDescriptor(key: "Forare", ascending: true)
        let js_hun = NSSortDescriptor(key: "Hund", ascending: true)
        let js_plt = NSSortDescriptor(key: "Plats", ascending: true)
        
        var jsonResult = (jsonResult2 as NSMutableArray).sortedArray(using: [js_for, js_hun])
        var c = 0
        
        for i in 0..<jsonResult.count
        {
            c += 1
            jsonElement = jsonResult[i] as! NSDictionary
            let ekipage = Ekipage()
            
// First Forare & Hund
            if forare.isEmpty && hund.isEmpty {
                forare = (jsonElement[cnst_Forare] as? String)!
                hund   = (jsonElement[cnst_Hund] as? String)!
                pwd    = (jsonElement[cnst_Gren] as? String)!
            }

// New Forare or Hund
            if ((jsonElement[cnst_Forare] as? String != forare) || (jsonElement[cnst_Hund] as? String != hund))
            {
                ekipage.Namn     = forare
                ekipage.Hund     = hund
                ekipage.Pwd      = pwd
                ekipage.Kls0Po   = Kls0Po
                ekipage.Kls1Po   = Kls1Po
                ekipage.Kls2Po   = Kls2Po
                ekipage.Kls3Po   = Kls3Po
                ekipage.Kls0Di   = Kls0Di
                ekipage.Kls1Di   = Kls1Di
                ekipage.Kls2Di   = Kls2Di
                ekipage.Kls3Di   = Kls3Di
                ekipage.TotDi    = Kls0Di + Kls1Di + Kls2Di + Kls3Di
                ekipage.TotSt    = Kls0St + Kls1St + Kls2St + Kls3St
                
// Add to Array
                Arr_Ekipages_lcl.append(ekipage)
                
                
// Next record
                forare     = (jsonElement[cnst_Forare] as? String)!
                hund       = (jsonElement[cnst_Hund] as? String)!
                klass      = (jsonElement[cnst_Klass] as? String)!
                pwd        = (jsonElement[cnst_Gren] as? String)!
                
// Get HighScore & HighDisc
                HighScore = self.GetHighScore(Kls0Po, Kl1: Kls1Po, Kl2: Kls2Po, Kl3: Kls3Po)
                HighDisc  = self.GetHighDisc(ekipage.TotDi)
                
// Initialize variables
                Kls0Po   = 0
                Kls0Di   = 0
                Kls1Po   = 0
                Kls2Po   = 0
                Kls3Po   = 0
                Kls1Di   = 0
                Kls2Di   = 0
                Kls3Di   = 0
                Kls1St   = 0
                Kls2St   = 0
                Kls3St   = 0
                pwd      = ""
            }
// Only 5 best results
            if ((Kls0St + Kls1St + Kls2St + Kls3St) > 4) {
                continue
            }
// Calculate Points & Disk
// Klass Öppen
            if ((jsonElement[cnst_Klass]) as! String == cnst_Ag0Ag || (jsonElement[cnst_Klass]) as! String == cnst_Ag0Ho) {
                Kls0Po += (((jsonElement[cnst_Poang])! as AnyObject).intValue)
                Kls0St += 1
                if jsonElement[cnst_Disk] as! String == cnst_Ja {
                    Kls0Di += 1
                }
            }
// Klass1
            if ((jsonElement[cnst_Klass]) as! String == cnst_Ag1Ag || (jsonElement[cnst_Klass]) as! String == cnst_Ag1Ho) {
                Kls1Po += (((jsonElement[cnst_Poang])! as AnyObject).intValue)
                Kls1St += 1
                if jsonElement[cnst_Disk] as! String == cnst_Ja {
                    Kls1Di += 1
                }
            }

// Klass2
            if ((jsonElement[cnst_Klass]) as! String == cnst_Ag2Ag || (jsonElement[cnst_Klass]) as! String == cnst_Ag2Ho) {
                Kls2Po += (((jsonElement[cnst_Poang])! as AnyObject).intValue)
                Kls2St += 1
                if jsonElement[cnst_Disk] as! String == cnst_Ja {
                    Kls2Di += 1
                }
            }

// Klass3
            if ((jsonElement[cnst_Klass]) as! String == cnst_Ag3Ag || (jsonElement[cnst_Klass]) as! String == cnst_Ag3Ho) {
                Kls3Po += (((jsonElement[cnst_Poang])! as AnyObject).intValue)
                Kls3St += 1
                if jsonElement[cnst_Disk] as! String == cnst_Ja {
                    Kls3Di += 1
                }
            }

// Last record
            if c == jsonResult.count {
                let ekipage_last = Ekipage()
                ekipage_last.Namn   = forare
                ekipage_last.Hund   = hund
                ekipage_last.Pwd    = pwd
                ekipage_last.Kls0Po = Kls0Po
                ekipage_last.Kls0Di = Kls0Di
                ekipage_last.Kls1Po = Kls1Po
                ekipage_last.Kls2Po = Kls2Po
                ekipage_last.Kls3Po = Kls3Po
                ekipage_last.Kls1Di = Kls1Di
                ekipage_last.Kls2Di = Kls2Di
                ekipage_last.Kls3Di = Kls3Di
                ekipage_last.TotDi  = Kls0Di + Kls1Di + Kls2Di + Kls3Di
                ekipage_last.TotSt  = Kls0St + Kls1St + Kls2St + Kls3St
                Arr_Ekipages_lcl.append(ekipage_last)
                HighScore = self.GetHighScore(Kls0Po, Kl1: Kls1Po, Kl2: Kls2Po, Kl3: Kls3Po)
                HighDisc  = self.GetHighDisc(ekipage_last.TotDi)
                }
            }
        Arr_Ekipages = Arr_Ekipages_lcl

// Prepare PickerViews if not prepared
            if (pickerDtaFo.count == 0 && pickerDtaHu.count == 0 && pickerDtaPlt.count == 0) {

                pickerDtaFo.append(" Förare?")
                pickerDtaHu.append(" Hund?")
                pickerDtaPlt.append(" Plats?")
// PickerView: Forare
                jsonResult = (jsonResult2 as NSMutableArray).sortedArray(using: [js_for])
                for i in 0..<jsonResult.count {
                    jsonElement = jsonResult[i] as! NSDictionary
                    
                    if forare != (jsonElement[cnst_Forare] as? String)! {
                        forare = (jsonElement[cnst_Forare] as? String)!
                        if pickerDtaFo.contains((jsonElement[cnst_Forare] as? String)!) {
                        } else {
                            pickerDtaFo.append((jsonElement[cnst_Forare] as? String)!)
                        }
                    }
                }
// PickerView: Hund
                jsonResult = (jsonResult2 as NSMutableArray).sortedArray(using: [js_hun])
                for i in 0..<jsonResult.count {
                    jsonElement = jsonResult[i] as! NSDictionary
                   
                    if hund != (jsonElement[cnst_Hund] as? String)! {
                        hund = (jsonElement[cnst_Hund] as? String)!
                        if pickerDtaHu.contains((jsonElement[cnst_Hund] as? String)!) {
                        } else {
                            pickerDtaHu.append((jsonElement[cnst_Hund] as? String)!)
                        }
                    }
                }
// PickerView: Plats
                jsonResult = (jsonResult2 as NSMutableArray).sortedArray(using: [js_plt])
                for i in 0..<jsonResult.count {
                    jsonElement = jsonResult[i] as! NSDictionary
             
                    if plats != (jsonElement[cnst_Plats] as? String)! {
                        plats = (jsonElement[cnst_Plats] as? String)!
                        if pickerDtaHu.contains((jsonElement[cnst_Plats] as? String)!) {
                        } else {
                            pickerDtaPlt.append((jsonElement[cnst_Plats] as? String)!)
                        }
                    }
                }

                DispatchQueue.main.async(execute: { () -> Void in
                    self.delegate.itemsDownloaded(Arr_Ekipages as NSArray)
                })
            }
    }
    
    func GetHighScore(_ Kl0: Int, Kl1: Int, Kl2: Int, Kl3: Int) -> Int {
        
        if HighScore < Kl0 {
            HighScore = Kl0
        } else if HighScore < Kl1 {
            HighScore = Kl1
        } else if HighScore < Kl2 {
            HighScore = Kl2
        } else if HighScore < Kl3 {
            HighScore = Kl3
        }
        x_scale = 200 / Float(HighScore)
        return HighScore
    }
    
    func GetHighDisc(_ TotDi: Int) -> Int {
        if HighDisc < TotDi {
            HighDisc = TotDi
        } 
        d_scale = 200 / Float(HighDisc)
        prc_scale = 200 / Float(100)
        return HighDisc
    }
}
