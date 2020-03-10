//
//  requestcell.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/1/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

class requestcell: UIView {

    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var acceptbtn: UIButton!
    @IBOutlet weak var denybtn: UIButton!
    
    
    func Input(any:Any,profilepic:String,username:String,acceptBtn:Selector,denyBtn:Selector){
        self.profilepic.loadimage(url: URL(string: profilepic)!)
        self.username.text = username
        self.acceptbtn.addTarget(any, action: acceptBtn, for: .touchUpInside)
        self.denybtn.addTarget(any, action: denyBtn, for: .touchUpInside)
        
    }
    

}
