//
//  delqueueCell.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/11/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

class delqueueCell: UIView {

    @IBOutlet weak var queueName: UILabel!
    @IBOutlet weak var timeperiod: UILabel!
    @IBOutlet weak var delbtn: UIButton!
    
    func Input(any:Any,queueName:String,timePeriod:String,delBtn:Selector) {
        self.queueName.text = queueName
        self.timeperiod.text = timePeriod
        self.delbtn.addTarget(any, action: delBtn, for: .touchUpInside)
    }

}
