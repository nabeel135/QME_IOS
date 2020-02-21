//
//  dayperiod.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/4/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

class dayperiod: UIView {

    @IBOutlet weak var fromdaypicker: UIPickerView!
    @IBOutlet weak var todaypicker: UIPickerView!
    @IBOutlet weak var cross: UIButton!
    
    var fromday = "Monday"
    var today = "Monday"
    
    @IBOutlet weak var save: UIButton!
    let day = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

    
    func Input(any:Any,saveBtn:Selector,crossBtn:Selector){
        self.save.addTarget(any, action: saveBtn, for: .touchUpInside)
        self.cross.addTarget(any, action: crossBtn, for: .touchUpInside)

        
        fromdaypicker.delegate = self
        todaypicker.delegate = self

        
    }
    
    
    
}




extension dayperiod: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return day[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fromdaypicker {
            fromday = day[row]
        }else{
            today = day[row]
        }
    }
    
}
