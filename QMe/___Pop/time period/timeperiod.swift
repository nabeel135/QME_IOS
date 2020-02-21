//
//  timeperiod.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/4/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

class timeperiod: UIView {


    let hours = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    let shift = ["AM","PM"]
    
    
    var fromtime = "1AM"
    var totime = "1AM"
    
    var fromhour = "1"
    var fromshift = "AM"
    var tohour = "1"
    var toshift = "AM"

    
    
    @IBOutlet weak var fromtimepicker: UIPickerView!
    @IBOutlet weak var totimepicker: UIPickerView!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var cross: UIButton!
    
    func Input(any:Any,saveBtn:Selector,crossBtn:Selector){
        self.save.addTarget(any, action: saveBtn, for: .touchUpInside)
        self.cross.addTarget(any, action: crossBtn, for: .touchUpInside)

        
        fromtimepicker.delegate = self
        totimepicker.delegate = self

        
    }
}




extension timeperiod: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         
        if component==0 {return 12}
        else{return 2}
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component==0 {return hours[row]}
        else{return shift[row]}
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView==fromtimepicker {
            if component==0 {fromhour = hours[row]}
            else{fromshift = shift[row]}
            fromtime = fromhour+fromshift
        }else{
            if component==0 {tohour = hours[row]}
            else{toshift = shift[row]}
            totime = tohour+toshift
        }
    }
    
    
    
    
    
}
