//
//  usercell.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/1/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

class usercell: UIView {

    @IBOutlet weak var shopname: UILabel!
    @IBOutlet weak var queuetotal: UILabel!
    
    
    
    func Input(ShopName:String,QueueTotal:String){
        self.shopname.text = ShopName
        self.queuetotal.text = QueueTotal
    }
    
}
