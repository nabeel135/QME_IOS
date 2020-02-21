//
//  menubar.swift
//  QMe
//
//  Created by Mr. Nabeel on 1/31/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import Foundation
import UIKit

let menubar = MB()
class MB:UIView{
    
    var body = UIView()
    var menu = UIView()
    
    
    //MARK:- admin menu bar APPEAR
    func AppearAdminMenu(parent:Any,ProfileName:String,DashboardBtn:Selector,editBtn:Selector,loginasclerkBtn:Selector,logoutBtn:Selector,inView:UIView) {
        appearcodeDuplication(inView: inView) {
            self.menu = nibView(fileName: "adminmenuNib", ownerClass: parent) as! adminmenu
            self.menu.frame = CGRect(x: -300, y: 0, width: 300, height: y)
            self.body.addSubview(self.menu)
            (self.menu as! adminmenu).Input(any: parent,
                                       ProfileName: ProfileName,
                                       DashboardBtn: DashboardBtn,
                                       editBtn: editBtn,
                                       loginasclerkBtn: loginasclerkBtn,
                                       logoutBtn: logoutBtn)
        }
        
    }
    
    
    
    
    //MARK:- user menu bar APPEAR

    func AppearUserMenu(parent:Any,ProfileName:String,DashboardBtn:Selector,editBtn:Selector,logoutBtn:Selector,inView:UIView) {
        appearcodeDuplication(inView: inView) {
            self.menu = nibView(fileName: "usermenuNib", ownerClass: parent) as! usermenu
            self.menu.frame = CGRect(x: -300, y: 0, width: 300, height: y)
            self.body.addSubview(self.menu)
            (self.menu as! usermenu).Input(any: parent,
                                           profilename: getString(key: userNamekey),
                                           dashboardBtn: DashboardBtn,
                                           editBtn: editBtn,
                                           logoutBtn: logoutBtn)
        }
    }
    
    
    //MARK:- hine menu bar

    @objc func clickonBody(){
        self.disAppear()
    }
    
    func disAppear(){
        UIView.animate(withDuration: 0.2, animations: {
            self.menu.frame.origin.x = -300
        }) { _ in
            self.body.removeFromSuperview()
        }
    }
    
    
    
    
    
    
    
    private func appearcodeDuplication(inView:UIView,justNib:@escaping ()->Void) {
                body.frame = CGRect(x: 0, y: 0, width: x, height: y)
        body.backgroundColor = .clear
        inView.addSubview(body)
        body.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickonBody)))
        
        justNib()
        
        UIView.animate(withDuration: 0.2) {
            self.body.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
            self.menu.frame.origin.x = 0
        }

    }
    
}
