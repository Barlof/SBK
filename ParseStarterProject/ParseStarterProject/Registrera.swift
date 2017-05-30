/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class Registrera: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate, UITextFieldDelegate  {

    var Parse_plac  = Int()
    var Parse_dat   = NSDate()
    var PlacPoang   = Int()
    
    @IBOutlet weak var Scrolleri: UIScrollView!
    @IBOutlet weak var Logga2: UIImageView!
    
    var pickerDataGr = ["Ag-Officiell", "Ag-InOff"]
    @IBOutlet var Logga: UITapGestureRecognizer!
    
    var pickerDtaFo = [""]
    var pickerDtaHu = [""]
    var pickerDtaGr = [""]
    var pickerDtaKl = [""]
    
    var pickerDataPl = ["1","2","3","4","5","6","7","8","9","10","11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    var pickerDataPi = ["Ja","Nej"]
    var pickerDataDi = ["Ja","Nej"]
    
    var choice = 0
    var locret = 0
    let dateformatter = NSDateFormatter()
    var Gren = ""
    var Name = ""
    var Hund = ""
    var Klass = ""

    @IBOutlet weak var fld_Datum: UITextField!
    @IBOutlet weak var fld_Rubrik: UILabel!
    @IBOutlet weak var fld_Info: UILabel!
    
    @IBOutlet weak var fld_Disk: UITextField!
    @IBOutlet weak var fld_Pinne: UITextField!

    @IBOutlet weak var DatePicker: UIDatePicker!

    @IBOutlet weak var fld_Plats: UITextField!
    @IBOutlet weak var Btn_Forare: UIButton!
    @IBOutlet weak var Btn_Hund: UIButton!
    
    @IBOutlet weak var Btn_Gren: UIButton!
    @IBOutlet weak var Btn_Klass: UIButton!
    @IBOutlet weak var Btn_Datum: UIButton!

    @IBOutlet weak var Btn_Plac: UIButton!
    @IBOutlet weak var Btn_Disk: UIButton!
    @IBOutlet weak var Btn_Pinne: UIButton!
    
    @IBOutlet weak var DatumPicker: UIDatePicker!
    @IBOutlet weak var YesNo: UIPickerView!
    
    @IBAction func DatumPickerAction(sender: UIButton) {
        let datumPickerView : UIDatePicker = UIDatePicker()
        datumPickerView.datePickerMode = UIDatePickerMode.Date
        datumPickerView.addTarget(self, action: #selector(Registrera.HandleDatumPicker(_:)), forControlEvents: UIControlEvents.ValueChanged)


        self.YesNo.hidden = true
        self.fld_Rubrik.hidden = false
        self.fld_Rubrik.text = "Svedala Brukshundsklubbs Barometer Rapportering"
        self.DatumPicker.hidden = true
        self.view.endEditing(true)

    }
// Actions
    @IBAction func Act_Forare(sender: AnyObject) {
        self.view.endEditing(true)
        self.fld_Rubrik.text = "Svedala Brukshundsklubbs Barometer Rapportering"
    }
    
    @IBAction func DatePickerAction(sender: UITextField) {

        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(Registrera.HandleDatePicker(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.YesNo.hidden = true
        self.fld_Rubrik.hidden = false
        self.fld_Rubrik.text = "Svedala Brukshundsklubbs Barometer Rapportering"
        self.DatumPicker.hidden = true
        self.view.endEditing(true)

}
    func HandleDatumPicker(sender: UIDatePicker) {
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "yyyyMMdd"
}

    func HandleDatePicker(sender: UIDatePicker) {
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "yyyyMMdd"
        self.fld_Datum.text = String (dateformatter.stringFromDate(sender.date))
        self.view.endEditing(true)
        self.DatumPicker.hidden = true
    }
    
    @IBAction func YesNo(sender: AnyObject) {
        choice = sender.tag
        self.YesNo.hidden = false
        self.fld_Rubrik.hidden = true
        self.fld_Info.hidden = true
        switch choice {
        case 1:
            self.YesNo.dataSource = pickerDtaGr as? UIPickerViewDataSource
            self.YesNo.becomeFirstResponder()
        case 2:
            self.YesNo.dataSource = pickerDtaFo as? UIPickerViewDataSource
            self.YesNo.becomeFirstResponder()
        case 3:
            self.YesNo.dataSource = pickerDtaHu as? UIPickerViewDataSource
            self.YesNo.becomeFirstResponder()
        case 6:
            self.YesNo.dataSource = pickerDtaKl as? UIPickerViewDataSource
            self.YesNo.becomeFirstResponder()
        case 7:
            self.YesNo.dataSource = pickerDataPl as? UIPickerViewDataSource
            self.YesNo.becomeFirstResponder()
        case 10:
            self.YesNo.dataSource = pickerDataPi as? UIPickerViewDataSource
            self.YesNo.becomeFirstResponder()
        case 11:
            self.YesNo.dataSource = pickerDataDi as? UIPickerViewDataSource
            self.YesNo.becomeFirstResponder()
        case 20:
            self.fld_Rubrik.hidden = false
            self.YesNo.hidden = true
            self.fld_Rubrik.text = "Tryck på Hunden till vänster, för att ta bort Tangenter"
            
        default:
            print("Default")
        }
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        LoadForareHund()

        Scrolleri.contentSize.height = 500
        
        Btn_Forare.setTitleColor(UIColor.blackColor(), forState: .Normal)
        Btn_Hund.setTitleColor(UIColor.blackColor(), forState: .Normal)
        Btn_Gren.setTitleColor(UIColor.blackColor(), forState: .Normal)
        Btn_Klass.setTitleColor(UIColor.blackColor(), forState: .Normal)
        Btn_Plac.setTitleColor(UIColor.blackColor(), forState: .Normal)
        Btn_Disk.setTitleColor(UIColor.blackColor(), forState: .Normal)
        Btn_Pinne.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        self.DatumPicker.hidden = true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if choice == 1 {
            return pickerDtaGr.count
        } else if choice == 2 {
            return pickerDtaFo.count
        } else if choice == 3 {
            return pickerDtaHu.count
        } else if choice == 6 {
            return pickerDtaKl.count
        } else if choice == 7 {
            return pickerDataPl.count
        } else if choice == 10 {
            return pickerDataPi.count
        } else if choice == 11 {
            return pickerDataDi.count
        }

        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) ->
        String? {
        if choice == 1 {
            return pickerDtaGr[row]
        } else if choice == 2 {
            return pickerDtaFo[row]
        } else if choice == 3 {
            return pickerDtaHu[row]
        } else if choice == 6 {
            return pickerDtaKl[row]
        } else if choice == 7 {
            return pickerDataPl[row]
        } else if choice == 10 {
            return pickerDataPi[row]
        } else if choice == 11 {
            return pickerDataDi[row]
        }

        return ("Ok")
    }


    func updateTextField(let sender: Int){

        if sender == 1 {
            let ans = pickerDtaGr[YesNo.selectedRowInComponent(0)]
            self.Btn_Gren.setTitle(ans, forState: .Normal)
            self.Btn_Gren.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            self.Btn_Gren.backgroundColor = UIColor.grayColor()
        } else if sender == 2 {
            let ans = pickerDtaFo[YesNo.selectedRowInComponent(0)]
            self.Btn_Forare.setTitle(ans, forState: .Normal)
            self.Btn_Forare.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            self.Btn_Forare.backgroundColor = UIColor.grayColor()
        } else if sender == 3 {
            let ans = pickerDtaHu[YesNo.selectedRowInComponent(0)]
            self.Btn_Hund.setTitle(ans, forState: .Normal)
            self.Btn_Hund.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            self.Btn_Hund.backgroundColor = UIColor.grayColor()
        } else if sender == 6 {
            let ans = pickerDtaKl[YesNo.selectedRowInComponent(0)]
            self.Btn_Klass.setTitle(ans, forState: .Normal)
            self.Btn_Klass.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            self.Btn_Klass.backgroundColor = UIColor.grayColor()
        } else if sender == 7 {
            let ans = pickerDataPl[YesNo.selectedRowInComponent(0)]
            self.Btn_Plac.setTitle(ans, forState: .Normal)
            self.Btn_Plac.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            self.Btn_Plac.backgroundColor = UIColor.grayColor()
        } else if sender == 10 {
            let ans = pickerDataPi[YesNo.selectedRowInComponent(0)]
            self.Btn_Disk.setTitle(ans, forState: .Normal)
            self.Btn_Disk.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            self.Btn_Disk.backgroundColor = UIColor.grayColor()
        } else if sender == 11 {
            let ans = pickerDataDi[YesNo.selectedRowInComponent(0)]
            self.Btn_Pinne.setTitle(ans, forState: .Normal)
            self.Btn_Pinne.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            self.Btn_Pinne.backgroundColor = UIColor.grayColor()
        }
        self.YesNo.hidden = true
        self.DatumPicker.hidden = true
        self.fld_Rubrik.hidden = false
        self.fld_Rubrik.text = "Svedala Brukshundsklubbs Barometer Rapportering"
        self.view.endEditing(true)

        tapping(1) //Update txtfield
        }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            updateTextField(choice)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
    }

    @IBAction func Save(sender: AnyObject) {
        
        var count = 0
        let testObject = PFObject(className: "Barometer_2016")
        let DateFormatter = NSDateFormatter()
        DateFormatter.dateFormat = "yyyyMMdd"
        
        if self.Btn_Forare.backgroundColor == UIColor.grayColor() {
            testObject["Forare"]    = self.Btn_Forare.titleLabel?.text
            count++
        }
        if self.Btn_Hund.backgroundColor == UIColor.grayColor() {
            testObject["Hund"]    = self.Btn_Hund.titleLabel?.text
            count++
        }
        if self.Btn_Gren.backgroundColor == UIColor.grayColor() {
            testObject["Gren"]    = self.Btn_Gren.titleLabel?.text
            count++
        }
        if self.Btn_Klass.backgroundColor == UIColor.grayColor() {
            testObject["Klass"]    = self.Btn_Klass.titleLabel?.text
            count++
        }
        if fld_Datum.text > "" {
            let dateFromString = DateFormatter.dateFromString(fld_Datum.text!)
            testObject["Datum"]   = dateFromString
            count++
        }
        if self.fld_Plats.text != "Håll ner" {
            testObject["Plats"]    = self.fld_Plats.text
            count++
        }
        if((self.Btn_Pinne.titleLabel?.text) == "Ja") {
            testObject["Pinne"]     = true
            count++
        }
        if((self.Btn_Pinne.titleLabel?.text) == "Nej") {
            testObject["Pinne"]     = false
            count++
        }
        if((self.Btn_Disk.titleLabel?.text) == "Ja") {
            testObject["Disk"]     = true
            count++
        }
        if((self.Btn_Disk.titleLabel?.text) == "Nej"){
            testObject["Disk"]     = false
            count++
        }
        
// Inte alla fält ifyllda
        if count < 8 {
            fld_Info.hidden = false
            fld_Info.text = "Tänk på att fylla i alla fält!"
        } else {
// Formattering: Placering
            PlacFormat((self.Btn_Plac.titleLabel?.text)!)
            testObject["Plac"]      = Parse_plac
// Uträkning: Poäng
            PoangBer(self.Btn_Gren.titleLabel?.text as String! , Plac: PlacFormat((self.Btn_Plac.titleLabel?.text)!))
            testObject["Poang"] = PlacPoang
            testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
            self.fld_Info.hidden = false
            self.fld_Info.text = "Resultatet är sparat!"
            self.LoadForareHund()
                }
            }
        }
 
    @IBAction func HandleTapping(sender: UITapGestureRecognizer) {
    }
    
// Tar bort keyborden
    @IBAction func tapping(sender: AnyObject) {
        self.view.endEditing(true)
        self.fld_Rubrik.text = "Svedala Brukshundsklubbs Barometer Rapportering"
        self.DatumPicker.hidden = true
        self.YesNo.hidden = true
    }
    
    func PoangBer(Gren: String, Plac: Int) -> Int {
        
        if (Gren.containsString("Offi")) {
            switch Plac {
            case 1:
                PlacPoang = 10
            case 2:
                PlacPoang = 8
            case 3:
                PlacPoang = 6
            case 4, 5, 6, 7, 8, 9, 10:
                PlacPoang = 5
            case 11, 12, 13, 14, 15, 16, 17, 18, 19:
                PlacPoang = 4
            default:
                PlacPoang = 1
            }
        } else if (Gren.containsString("InOff")) {
            switch Plac {
            case 1:
                PlacPoang = 6
            case 2:
                PlacPoang = 5
            case 3:
                PlacPoang = 4
            case 4, 5, 6, 7, 8, 9, 10:
                PlacPoang = 3
            case 11, 12, 13, 14, 15, 16, 17, 18, 19:
                PlacPoang = 2
            default:
                PlacPoang = 1
            }
        }
        return PlacPoang
    }

    func PlacFormat(Input: String) -> Int {
        
        if Input == "1" {
            Parse_plac = 1
            } else if Input == "2" {
                Parse_plac = 2
            } else if Input == "3" {
                Parse_plac = 3
            } else if Input == "4" {
                Parse_plac = 4
            } else if Input == "5" {
                Parse_plac = 5
            } else if Input == "6" {
                Parse_plac = 6
            } else if Input == "7" {
                Parse_plac = 7
            } else if Input == "8" {
                Parse_plac = 8
            } else if Input == "9" {
                Parse_plac = 9
            } else if Input == "10" {
                Parse_plac = 10
            } else if Input == "11" {
                Parse_plac = 11
            } else if Input == "12" {
                Parse_plac = 12
            } else if Input == "13" {
                Parse_plac = 13
            } else if Input == "14" {
                Parse_plac = 14
            } else if Input == "15" {
                Parse_plac = 15
            } else if Input == "16" {
                Parse_plac = 16
            } else if Input == "17" {
                Parse_plac = 17
            } else if Input == "18" {
                Parse_plac = 18
            } else if Input == "19" {
                Parse_plac = 19
            } else if Input == "20" {
                Parse_plac = 20
            }
        return Parse_plac
    }
    
    func DateFormat(Input: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        Parse_dat = dateFormatter.dateFromString(Input)!
        return (Parse_dat)
    }
    
    
/*
        }
    }

// MARK: - Navigation
    
// In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        segue.destinationViewController
    
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
//    }
    
*/
}

//}
