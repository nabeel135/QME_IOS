//
//  notificationCellNib.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/12/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

class notificationCellNib: UIView {

    @IBOutlet weak var message: UILabel!
    
    
    func Input(message:String){
        self.message.text = message
    }

}
