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
    
    
    
    func Input(any:Any,QueueName:String,QueueTotal:String,AppointmentBtn:Selector,last:Bool){
        self.queuename.text = QueueName
        self.queuetotal.text = QueueTotal
        self.appointmentbtn.addTarget(any, action: AppointmentBtn, for: .touchUpInside)
        
        if last && userShopListobj.count>0 {
            apIobj.unAssignedQueue(any: any as! UIViewController, shopId: userShopListobj[Selectedshopindex].shop_id) {
            self.queuetotal.text = "\(unAssignedQueueList.count)"}
        }
        
    }

}
