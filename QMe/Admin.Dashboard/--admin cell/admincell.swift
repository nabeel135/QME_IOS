//
//  admincell.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/1/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

class admincell: UIView {

    @IBOutlet weak var shopename: UILabel!
    @IBOutlet weak var textfield: sbTextField!
    @IBOutlet weak var plusbtn: UIButton!
    @IBOutlet weak var minusbtn: UIButton!
    
    
    func Input(any:Any,shopename:String,textfield:String,addQueue:Selector,delQueue:Selector){
        
        self.shopename.text = shopename
        self.textfield.text = textfield
        self.textfield.isEnabled = false
        self.textfield.keyboardType = .numberPad
        self.plusbtn.addTarget(any, action: addQueue, for: .touchUpInside)
        self.minusbtn.addTarget(any, action: delQueue, for: .touchUpInside)
    }
    
    
    
    
    
    
    
}
