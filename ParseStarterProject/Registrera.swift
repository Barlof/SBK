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

// PICKERVIEWS
var pickerDtaFo = [String]() // Välj förare nedan
var pickerDtaHu = [String]()  // Välj hund nedan
var pickerDtaPlt = [String]() // Välj plats nedan


class Registrera: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate, UITextFieldDelegate  {    
    
// VARIABLES
    var data : NSMutableData = NSMutableData()
    var Parse_plac  = Int()
    var Parse_dat   = Date()
    var PlacPoang   = Int()
    var Check       = Int()

// CONSTANTS
    let cnst_Ja  = "Ja"
    let cnst_SBK = "Svedala Brukshundsklubbs Barometer Rapportering"
    let URL_API_Insert = "http://momflytt.se/api/insert.php"
    
// PICKERVIEWS
    let pickerDtaGr = ["AgOfficiell", "AgInOfficiell"]
    let pickerDtaKl = ["Klass?", "Öp-Hopp", "Öp-Agility", "Ag1Hopp", "Ag1Agility", "Ag2Hopp", "Ag2Agility", "Ag3Hopp", "Ag3Agility"]
    let pickerDataPlc = ["Placering?", "1","2","3","4","5","6","7","8","9","10","11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "Oplacerad  "]
    let pickerDataPi = ["Pinne?", "Ja","Nej"]
    let pickerDataDi = ["Disk?", "Ja","Nej"]
    let pickerDataNo = ["Nollat?", "Ja", "Nej"]
    
    var choice = 0
    let dateformatter = DateFormatter()
    var Gren = ""
    var Name = ""
    var Hund = ""
    var Klass = ""

// OUTLETS
// TextFields
    @IBOutlet weak var fld_Datum: UITextField!
    @IBOutlet weak var fld_Disk: UITextField!
    @IBOutlet weak var fld_Pinne: UITextField!
    @IBOutlet weak var fld_Plats: UITextField!
    @IBOutlet weak var fld_pwd: UITextField!

// Labels
    @IBOutlet weak var fld_Rubrik: UILabel!
    @IBOutlet weak var fld_Info: UILabel!

// Buttons
    @IBOutlet weak var Btn_Forare: UIButton!
    @IBOutlet weak var Btn_Hund: UIButton!
    @IBOutlet weak var Btn_Klass: UIButton!
    @IBOutlet weak var Btn_Plats: UIButton!
    @IBOutlet weak var Btn_Plac: UIButton!
    @IBOutlet weak var Btn_Disk: UIButton!
    @IBOutlet weak var Btn_Pinne: UIButton!
    @IBOutlet weak var Btn_Noll: UIButton!    
    @IBOutlet weak var Btn_Spara: UIButton!

// DatePicker
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var DatumPicker: UIDatePicker!

// ScrollView
    @IBOutlet weak var Scrolleri: UIScrollView!

// TapGestureRecognizer
    @IBOutlet var Logga: UITapGestureRecognizer!
    
// PickerView
    @IBOutlet weak var YesNo: UIPickerView!

// ACTIONS

    @IBAction func DatumPickerAction(_ sender: UIButton) {
        let datumPickerView : UIDatePicker = UIDatePicker()
        datumPickerView.datePickerMode = UIDatePickerMode.date
        datumPickerView.addTarget(self, action: #selector(Registrera.HandleDatumPicker(_:)), for: UIControlEvents.valueChanged)

        self.YesNo.isHidden = true
        self.fld_Rubrik.isHidden = false
        self.fld_Rubrik.text = cnst_SBK
        self.DatumPicker.isHidden = true
        self.view.endEditing(true)

    }

    @IBAction func Act_Forare(_ sender: AnyObject) {
        self.view.endEditing(true)
        self.fld_Rubrik.text = cnst_SBK
    }
    
    @IBAction func DatePickerAction(_ sender: UITextField) {

        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(Registrera.HandleDatePicker(_:)), for: UIControlEvents.valueChanged)
        self.YesNo.isHidden = true
        self.fld_Rubrik.isHidden = false
        self.fld_Rubrik.text = cnst_SBK
        self.DatumPicker.isHidden = true
        self.view.endEditing(true)
    }
    
    @IBAction func Save(_ sender: AnyObject) {
 
        let DateFormatter = Foundation.DateFormatter()
        DateFormatter.dateFormat = "yyyy-MM-dd"
        self.fld_Info.text = "Felaktigt lösenord"
// Check correct password
        for ekipage in Arr_Ekipages {
            if ekipage.Namn == Btn_Forare.currentTitle {
                if ekipage.Pwd == fld_pwd.text {
                    break
                } else {
                    self.fld_Info.isHidden = false
                    self.fld_Info.text = "Felaktigt lösenord"
                    return
                }
            }
        }
//        }
// Variables for getting values from Buttons
        let Forare      = Btn_Forare.currentTitle
        let Hund        = Btn_Hund.currentTitle
        let Klass       = Btn_Klass.currentTitle
        let Plats       = Btn_Plats.currentTitle
        let Plac        = Btn_Plac.currentTitle
        let Disk        = Btn_Disk.currentTitle
        let Pinne       = Btn_Pinne.currentTitle
        let Nollat      = Btn_Noll.currentTitle
        let Datum_str   = fld_Datum.text
        let Pwd         = fld_pwd.text

        if ((Klass?.contains("Ag1")) != nil) {
            PlacPoang = 1
        }
        
        if Disk == cnst_Ja {
            PlacPoang = 2   //Two points for participants
        } else {
            PlacPoang = PoangBer_new(PlacFormat((self.Btn_Plac.titleLabel?.text)!), Pinne: Pinne!, Nollat: Nollat!)
        }

// Write to dB
        var postParameters = "Forare="+Forare!+"&Hund="+Hund!+"&Gren="+Pwd!+"&Klass="+Klass!
        postParameters.write("&Datum="+Datum_str!+"&Plats="+Plats!)
        postParameters.write("&Plac="+Plac!+"&Disk="+Disk!+"&Pinne="+Pinne!)
        postParameters.write("&Poang=")
        postParameters.write(String(PlacPoang))
        
        self.fld_Info.isHidden = false
        self.fld_Info.text = "Var god vänta..."
        
// Created NSURL
        var requestURL = URLRequest(url: URL(string: URL_API_Insert)!)
        
// Setting the method to use
        requestURL.httpMethod = "POST"
        
// Adding the parameters to request body
        requestURL.httpBody = postParameters.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: requestURL) {
            data, response, error in
             guard let _ = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }

            if error != nil {
                return
            }

            self.ClearFields()
            self.fld_Info.text = "Resultatet är sparat!"
        } //)

        task.resume()

// Check if all fields selected
        Check = CheckAllFields()
        if Check == 0 {
            Btn_Spara.backgroundColor = UIColor.black
            Btn_Spara.setTitleColor(UIColor.white, for: UIControlState())
            Btn_Spara.isEnabled = true
        }else {
            Btn_Spara.backgroundColor = UIColor.lightGray
            Btn_Spara.isEnabled = false
        }
    }

// Handle drilldown depending on datafield
    @IBAction func YesNo(_ sender: AnyObject) {
        choice = sender.tag
        if self.YesNo.isHidden == true {
            self.YesNo.isHidden = false
            self.fld_Rubrik.isHidden = true
            self.fld_Info.isHidden = true
        } else {
            self.YesNo.isHidden = true
            self.fld_Rubrik.isHidden = false
            self.fld_Info.isHidden = true
        }
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
        case 5:
            self.YesNo.dataSource = pickerDtaPlt as? UIPickerViewDataSource
            self.YesNo.becomeFirstResponder()
        case 6:
            self.YesNo.dataSource = pickerDtaKl as? UIPickerViewDataSource
            self.YesNo.becomeFirstResponder()
        case 7:
            self.YesNo.dataSource = pickerDataPlc as? UIPickerViewDataSource
            self.YesNo.becomeFirstResponder()
        case 10:
            self.YesNo.dataSource = pickerDataDi as? UIPickerViewDataSource
            self.YesNo.becomeFirstResponder()
        case 11:
            self.YesNo.dataSource = pickerDataPi as? UIPickerViewDataSource
            self.YesNo.becomeFirstResponder()
        case 12:
            self.YesNo.dataSource = pickerDataNo as? UIPickerViewDataSource
            self.YesNo.becomeFirstResponder()

        default:
            print("Default")
        }
        
// Check all fields selected
        Check = CheckAllFields()
        if Check == 0 {
            Btn_Spara.backgroundColor = UIColor.black
            Btn_Spara.setTitleColor(UIColor.white, for: UIControlState())
            Btn_Spara.isEnabled = true
        }else {
            Btn_Spara.backgroundColor = UIColor.lightGray
            Btn_Spara.setTitleColor(UIColor.white, for: UIControlState())
            Btn_Spara.isEnabled = false
        }
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        Scrolleri.contentSize.height = 500
        
        Btn_Forare.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Forare.layer.cornerRadius = 5
        Btn_Hund.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Hund.layer.cornerRadius = 5
        Btn_Klass.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Klass.layer.cornerRadius = 5
        Btn_Plac.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Plac.layer.cornerRadius = 5
        Btn_Disk.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Disk.layer.cornerRadius = 5
        Btn_Pinne.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Pinne.layer.cornerRadius = 5
        Btn_Noll.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Noll.layer.cornerRadius = 5
        Btn_Plats.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Plats.layer.cornerRadius = 5
        Btn_Spara.setTitleColor(UIColor.white, for: UIControlState())
        Btn_Spara.backgroundColor = UIColor.lightGray
        Btn_Spara.layer.cornerRadius = 5
        Btn_Spara.isEnabled = true
        updateTextField(1)
        
        self.DatumPicker.isHidden = true
        self.YesNo.dataSource = self
        self.YesNo.delegate   = self
    }
  
// FUNCTIONS
    func HandleDatumPicker(_ sender: UIDatePicker) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyyMMdd"
    }
    
    func HandleDatePicker(_ sender: UIDatePicker) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        self.fld_Datum.text = String (dateformatter.string(from: sender.date))
        self.view.endEditing(true)
        self.DatumPicker.isHidden = true
        fld_Datum.textColor = UIColor.white
        fld_Datum.backgroundColor = UIColor.lightGray
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if choice == 1 {
            return pickerDtaGr.count
        } else if choice == 2 {
            return pickerDtaFo.count
        } else if choice == 3 {
            return pickerDtaHu.count
        } else if choice == 5 {
            return pickerDtaPlt.count
        } else if choice == 6 {
            return pickerDtaKl.count
        } else if choice == 7 {
            return pickerDataPlc.count
        } else if choice == 10 {
            return pickerDataDi.count
        } else if choice == 11 {
            return pickerDataPi.count
        } else if choice == 12 {
            return pickerDataNo.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) ->
        String? {
        if choice == 1 {
            return pickerDtaGr[row]
        } else if choice == 2 {
            return pickerDtaFo[row]
        } else if choice == 3 {
            return pickerDtaHu[row]
        } else if choice == 5 {
            return pickerDtaPlt[row]
        } else if choice == 6 {
            return pickerDtaKl[row]
        } else if choice == 7 {
            return pickerDataPlc[row]
        } else if choice == 10 {
            return pickerDataDi[row]
        } else if choice == 11 {
            return pickerDataPi[row]
        } else if choice == 12 {
            return pickerDataNo[row]
            }
        return ("Ok")
    }
    
    func updateTextField(_ sender: Int){

        if sender == 1 {
        } else if sender == 2 {
            let ans = pickerDtaFo[YesNo.selectedRow(inComponent: 0)]
            if ans == " Förare?" {
                self.Btn_Forare.setTitle(ans, for: UIControlState())
                self.Btn_Forare.setTitleColor(UIColor.black, for: UIControlState())
                self.Btn_Forare.backgroundColor = UIColor.white
            } else {
                self.Btn_Forare.setTitle(ans, for: UIControlState())
                self.Btn_Forare.setTitleColor(UIColor.white, for: UIControlState())
                self.Btn_Forare.backgroundColor = UIColor.lightGray
            }

        } else if sender == 3 {
            let ans = pickerDtaHu[YesNo.selectedRow(inComponent: 0)]
            if ans == " Hund?" {
                self.Btn_Hund.setTitle(ans, for: UIControlState())
                self.Btn_Hund.setTitleColor(UIColor.black, for: UIControlState())
                self.Btn_Hund.backgroundColor = UIColor.white
            } else {
                self.Btn_Hund.setTitle(ans, for: UIControlState())
                self.Btn_Hund.setTitleColor(UIColor.white, for: UIControlState())
                self.Btn_Hund.backgroundColor = UIColor.lightGray
            }

        } else if sender == 5 {
            let ans = pickerDtaPlt[YesNo.selectedRow(inComponent: 0)]
            if ans == " Plats?" {
                self.Btn_Plats.setTitle(ans, for: UIControlState())
                self.Btn_Plats.setTitleColor(UIColor.black, for: UIControlState())
                self.Btn_Plats.backgroundColor = UIColor.white
            } else {
                self.Btn_Plats.setTitle(ans, for: UIControlState())
                self.Btn_Plats.setTitleColor(UIColor.white, for: UIControlState())
                self.Btn_Plats.backgroundColor = UIColor.lightGray
            }

        } else if sender == 6 {
            let ans = pickerDtaKl[YesNo.selectedRow(inComponent: 0)]
            if ans == "Klass?" {
                self.Btn_Klass.setTitle(ans, for: UIControlState())
                self.Btn_Klass.setTitleColor(UIColor.black, for: UIControlState())
                self.Btn_Klass.backgroundColor = UIColor.white
            } else {
                self.Btn_Klass.setTitle(ans, for: UIControlState())
                self.Btn_Klass.setTitleColor(UIColor.white, for: UIControlState())
                self.Btn_Klass.backgroundColor = UIColor.lightGray
            }

        } else if sender == 7 {
            let ans = pickerDataPlc[YesNo.selectedRow(inComponent: 0)]
            if ans == "Placering?" {
                self.Btn_Plac.setTitle(ans, for: UIControlState())
                self.Btn_Plac.setTitleColor(UIColor.black, for: UIControlState())
                self.Btn_Plac.backgroundColor = UIColor.white
            } else {
                self.Btn_Plac.setTitle(ans, for: UIControlState())
                self.Btn_Plac.setTitleColor(UIColor.white, for: UIControlState())
                self.Btn_Plac.backgroundColor = UIColor.lightGray
            }

        } else if sender == 10 {
            let ans = pickerDataDi[YesNo.selectedRow(inComponent: 0)]
            if ans == "Disk?" {
                self.Btn_Disk.setTitle(ans, for: UIControlState())
                self.Btn_Disk.setTitleColor(UIColor.black, for: UIControlState())
                self.Btn_Disk.backgroundColor = UIColor.white
                self.Btn_Pinne.setTitle("Pinne?", for: UIControlState())
                self.Btn_Pinne.setTitleColor(UIColor.black, for: UIControlState())
                self.Btn_Pinne.backgroundColor = UIColor.white
                self.Btn_Noll.setTitle("Nollat?", for: UIControlState())
                self.Btn_Noll.setTitleColor(UIColor.black, for: UIControlState())
                self.Btn_Noll.backgroundColor = UIColor.white
                self.Btn_Plac.setTitle("Placering?", for: UIControlState())
                self.Btn_Plac.setTitleColor(UIColor.black, for: UIControlState())
                self.Btn_Plac.backgroundColor = UIColor.white
            } else if ans == "Ja" {
                self.Btn_Disk.setTitle(ans, for: UIControlState())
                self.Btn_Disk.setTitleColor(UIColor.white, for: UIControlState())
                self.Btn_Disk.backgroundColor = UIColor.lightGray
                self.Btn_Pinne.setTitle("Nej", for: UIControlState())
                self.Btn_Pinne.setTitleColor(UIColor.white, for: UIControlState())
                self.Btn_Pinne.backgroundColor = UIColor.lightGray
                self.Btn_Noll.setTitle("Nej", for: UIControlState())
                self.Btn_Noll.setTitleColor(UIColor.white, for: UIControlState())
                self.Btn_Noll.backgroundColor = UIColor.lightGray
                self.Btn_Plac.setTitle("Oplacerad", for: UIControlState())
                self.Btn_Plac.setTitleColor(UIColor.white, for: UIControlState())
                self.Btn_Plac.backgroundColor = UIColor.lightGray

            } else if ans == "Nej" {
                self.Btn_Disk.setTitle(ans, for: UIControlState())
                self.Btn_Disk.setTitleColor(UIColor.white, for: UIControlState())
                self.Btn_Disk.backgroundColor = UIColor.lightGray
                self.Btn_Pinne.setTitle("Pinne?", for: UIControlState())
                self.Btn_Pinne.setTitleColor(UIColor.black, for: UIControlState())
                self.Btn_Pinne.backgroundColor = UIColor.white
                self.Btn_Noll.setTitle("Nollat?", for: UIControlState())
                self.Btn_Noll.setTitleColor(UIColor.black, for: UIControlState())
                self.Btn_Noll.backgroundColor = UIColor.white
                self.Btn_Plac.setTitle("Placering?", for: UIControlState())
                self.Btn_Plac.setTitleColor(UIColor.black, for: UIControlState())
                self.Btn_Plac.backgroundColor = UIColor.white
            }

        } else if sender == 11 {
            let ans = pickerDataPi[YesNo.selectedRow(inComponent: 0)]
            if ans == "Pinne?" {
                self.Btn_Pinne.setTitle(ans, for: UIControlState())
                self.Btn_Pinne.setTitleColor(UIColor.black, for: UIControlState())
                self.Btn_Pinne.backgroundColor = UIColor.white
            } else {
                self.Btn_Pinne.setTitle(ans, for: UIControlState())
                self.Btn_Pinne.setTitleColor(UIColor.white, for: UIControlState())
                self.Btn_Pinne.backgroundColor = UIColor.lightGray
            }

        } else if sender == 12 {
            let ans = pickerDataNo[YesNo.selectedRow(inComponent: 0)]
            if ans == "Nollat?" {
                self.Btn_Noll.setTitle(ans, for: UIControlState())
                self.Btn_Noll.setTitleColor(UIColor.black, for: UIControlState())
                self.Btn_Noll.backgroundColor = UIColor.white
            } else {
                self.Btn_Noll.setTitle(ans, for: UIControlState())
                self.Btn_Noll.setTitleColor(UIColor.white, for: UIControlState())
                self.Btn_Noll.backgroundColor = UIColor.lightGray
            }
        }

        self.YesNo.isHidden = true
        self.DatumPicker.isHidden = true
        self.fld_Rubrik.isHidden = false
        self.fld_Rubrik.text = cnst_SBK
        self.view.endEditing(true)

        tapping(1 as AnyObject) //Update txtfield
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            updateTextField(choice)
        
// Check if input in all fields
        Check = CheckAllFields()
        if Check == 0 {
            Btn_Spara.backgroundColor = UIColor.black
            Btn_Spara.setTitleColor(UIColor.white, for: UIControlState())
            Btn_Spara.isEnabled = true
        }else {
            Btn_Spara.backgroundColor = UIColor.lightGray
            Btn_Spara.setTitleColor(UIColor.white, for: UIControlState())
            Btn_Spara.isEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
    }

    func ClearFields() {
        Btn_Forare.backgroundColor = UIColor.white
        Btn_Forare.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Forare.setTitle("Förare", for: UIControlState())
        Btn_Hund.backgroundColor = UIColor.white
        Btn_Hund.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Hund.setTitle("Hund", for: UIControlState())
        Btn_Klass.backgroundColor = UIColor.white
        Btn_Klass.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Klass.setTitle("Klass", for: UIControlState())
        Btn_Plats.backgroundColor = UIColor.white
        Btn_Plats.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Plats.setTitle("Plats", for: UIControlState())
        Btn_Plac.backgroundColor = UIColor.white
        Btn_Plac.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Plac.setTitle("Placering", for: UIControlState())
        Btn_Disk.backgroundColor = UIColor.white
        Btn_Disk.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Disk.setTitle("Disk", for: UIControlState())
        
        Btn_Pinne.backgroundColor = UIColor.white
        Btn_Pinne.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Pinne.setTitle("Pinne", for: UIControlState())
        Btn_Noll.backgroundColor = UIColor.white
        Btn_Noll.setTitleColor(UIColor.black, for: UIControlState())
        Btn_Noll.setTitle("Nollat", for: UIControlState())
        
        fld_Datum.textColor = UIColor.black
        fld_Datum.backgroundColor = UIColor.white
        fld_Datum.text = "Datum"
        Btn_Spara.backgroundColor = UIColor.lightGray
        Btn_Spara.setTitleColor(UIColor.white, for: UIControlState())
        Btn_Spara.isEnabled = false
        
    }

// Remove keyboard
    @IBAction func tapping(_ sender: AnyObject) {
        self.view.endEditing(true)
        self.fld_Rubrik.text = cnst_SBK
        self.DatumPicker.isHidden = true
        self.YesNo.isHidden = true
    }

// Calculating points
//  Nollat lopp => + 100 poäng, Pinne => + 50 poäng
    func PoangBer_new(_ Plac: Int, Pinne: String, Nollat: String) -> Int {
    
        switch Plac {
            case 1:
                PlacPoang = 200
            case 2:
                PlacPoang = 180
            case 3:
                PlacPoang = 160
            case 4:
                PlacPoang = 140
            case 5:
                PlacPoang = 120
            case 6:
                PlacPoang = 100
            case 7:
                PlacPoang = 90
            case 8:
                PlacPoang = 80
            case 9:
                PlacPoang = 70
            case 10:
                PlacPoang = 60
            case 11:
                PlacPoang = 50
            case 12:
                PlacPoang = 45
            case 13:
                PlacPoang = 40
            case 14:
                PlacPoang = 35
            case 15:
                PlacPoang = 30
            case 16:
                PlacPoang = 25
            case 17:
                PlacPoang = 20
            case 18:
                PlacPoang = 15
            case 19:
                PlacPoang = 10
            case 20:
                PlacPoang = 5
            default:
                PlacPoang = 1
            }
        if Pinne == "Ja" {
            PlacPoang += 50
        }
        if Nollat == "Ja" {
            PlacPoang += 100
        }
        return PlacPoang
    }

// Change format (String => Integer)
    func PlacFormat(_ Input: String) -> Int {
        
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

// Set correct dateformat
    func DateFormat(_ Input: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        Parse_dat = dateFormatter.date(from: Input)!
        return (Parse_dat)
    }
    
    func CheckAllFields() -> Int {
// Input in all fields?
        var count = 0
        
        if self.Btn_Forare.backgroundColor == UIColor.lightGray {
            count += 1
        }
        if self.Btn_Hund.backgroundColor == UIColor.lightGray {
            count += 1
        }
        if self.Btn_Klass.backgroundColor == UIColor.lightGray {
            count += 1
        }
        if fld_Datum.backgroundColor == UIColor.lightGray {
            count += 1
        }
        if self.Btn_Plats.backgroundColor == UIColor.lightGray {
            count += 1
        }
        if self.Btn_Plac.backgroundColor == UIColor.lightGray {
            count += 1
        }
        if self.Btn_Pinne.backgroundColor == UIColor.lightGray {
            count += 1
        }
        if self.Btn_Disk.backgroundColor == UIColor.lightGray {
            count += 1
        }
        if self.Btn_Noll.backgroundColor == UIColor.lightGray {
            count += 1
        }
        
// Not input in all fields
        if count < 9 {
            return (1)
        } else {
            return (0)
        }
    }

// MARK: - Navigation
    
// In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        segue.destinationViewController
    
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
//    }
    

}
