//
//  usermenu.swift
//  QMe
//
//  Created by Mr. Nabeel on 1/31/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

class usermenu: UIView {

    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var profilename: UILabel!
    @IBOutlet weak var dashboardBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    
    
    
    func Input(any:Any,profilename:String,dashboardBtn:Selector,editBtn:Selector,logoutBtn:Selector){
        self.profilepic.loadimage(url: URL(string: getString(key: userImagkey))!)
        self.profilename.text = profilename
        self.dashboardBtn.addTarget(any, action: dashboardBtn, for: .touchUpInside)
        self.editBtn.addTarget(any, action: editBtn, for: .touchUpInside)
        self.logoutBtn.addTarget(any, action: logoutBtn, for: .touchUpInside)
    }
    
    
}
