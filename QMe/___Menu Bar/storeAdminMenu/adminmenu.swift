//
//  adminmenu.swift
//  QMe
//
//  Created by Mr. Nabeel on 1/31/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

class adminmenu: UIView {

    @IBOutlet var profilepic: UIImageView!
    @IBOutlet var profilename: UILabel!
    @IBOutlet var dashboardBtn: UIButton!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var loginasClerkBtn: UIButton!
    @IBOutlet var logoutBtn: UIButton!
    
    
    
    func Input(any:Any,ProfileName:String,DashboardBtn:Selector,editBtn:Selector,loginasclerkBtn:Selector,logoutBtn:Selector){
        self.profilepic.loadimage(url: URL(string: getString(key: userImagkey))!)
        self.profilename.text = ProfileName
        self.dashboardBtn.addTarget(any, action: DashboardBtn, for: .touchUpInside)
        self.editBtn.addTarget(any, action: editBtn, for: .touchUpInside)
        self.loginasClerkBtn.addTarget(any, action: loginasclerkBtn, for: .touchUpInside)
        self.logoutBtn.addTarget(any, action: logoutBtn, for: .touchUpInside)
    }

}
