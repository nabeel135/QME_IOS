//
//  usercell.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/2/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

class usershopcell: UIView {

    @IBOutlet weak var queuename: UILabel!
    @IBOutlet weak var queuetotal: UILabel!
    @IBOutlet weak var appointmentbtn: UIButton!
    
    
    
    func Input(any:Any,QueueName:String,QueueTotal:String,AppointmentBtn:Selector){
        self.queuename.text = QueueName
        self.queuetotal.text = QueueTotal
        self.appointmentbtn.addTarget(self, action: AppointmentBtn, for: .touchUpInside)
    }

}
