//
//  popup.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/4/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

let popup = PU()
class PU: UIView {
    
    var nibview = UIView()
    var parent = UIViewController()
    
    func AppearAddnewShop(parent:Any){
        self.parent = parent as! UIViewController
        
        let v = nibView(fileName: "addnewshopNib", ownerClass: self) as! addnewshop
        v.frame = (parent as! UIViewController).view.frame
        (parent as! UIViewController).view.addSubview(v)
        v.Input(any: parent)
        self.nibview = v
    }
    
    
    
    var daylabel = UILabel()
    func Appeardayperiodpicker(parent:Any,label:UILabel){
        self.parent = parent as! UIViewController

        daylabel = label
        
        let v = nibView(fileName: "dayperiodNib", ownerClass: self) as! dayperiod
        v.frame = (parent as! UIViewController).view.frame
        (parent as! UIViewController).view.addSubview(v)
        v.Input(any: self, saveBtn: #selector(savedayperiodbtn), crossBtn: #selector(crossbtn(_:)))
        
        self.nibview = v
    }
    
    @objc func savedayperiodbtn(_ btn:UIButton){
        btn.bouncybutton {
            self.daylabel.text = "\((self.nibview as! dayperiod).fromday)-\((self.nibview as! dayperiod).today)"
            let obj = adminShopListobj[Selectedshopindex]
            apIobj.updateShopAPI(any: self.parent,
                                 shopId: obj.shopid,
                                 shopCode: obj.shop_code,
                                 shopName: obj.shop_name,
                                 shopimagURL: obj.shopimag,
                                 fromDay: (self.nibview as! dayperiod).fromday,
                                 toDay: (self.nibview as! dayperiod).today,
                                 fromTime: obj.fromtime,
                                 toTime: obj.totime,
                                 adminId: obj.admin_id,
                                 status: obj.status)
            obj.fromday = (self.nibview as! dayperiod).fromday
            obj.today = (self.nibview as! dayperiod).today
            popup.disAppear()
        }
        
    }
    
    
    
    
    
    
    var timelabel = UILabel()
    func Appeartimeperiodpicker(parent:Any,label:UILabel){
        self.parent = parent as! UIViewController

        timelabel = label
        
        let v = nibView(fileName: "timeperiodNib", ownerClass: self) as! timeperiod
        v.frame = (parent as! UIViewController).view.frame
        (parent as! UIViewController).view.addSubview(v)
        v.Input(any: self, saveBtn: #selector(savetimeperiodbtn), crossBtn: #selector(crossbtn(_:)))
        
        self.nibview = v
    }
    
    @objc func savetimeperiodbtn(_ btn:UIButton){
        btn.bouncybutton {
            self.timelabel.text = "\((self.nibview as! timeperiod).fromtime)-\((self.nibview as! timeperiod).totime)"
            let obj = adminShopListobj[Selectedshopindex]
            apIobj.updateShopAPI(any: self.parent,
                                 shopId: obj.shopid,
                                 shopCode: obj.shop_code,
                                 shopName: obj.shop_name,
                                 shopimagURL: obj.shopimag,
                                 fromDay: obj.fromday,
                                 toDay: obj.today,
                                 fromTime: (self.nibview as! timeperiod).fromtime,
                                 toTime: (self.nibview as! timeperiod).totime,
                                 adminId: obj.admin_id,
                                 status: obj.status)
            obj.fromtime = (self.nibview as! timeperiod).fromtime
            obj.totime = (self.nibview as! timeperiod).totime
            popup.disAppear()
        }
        
    }
    
    @objc func crossbtn(_ btn:UIButton){
        btn.bouncybutton {
            popup.disAppear()
        }
    }
    
    // appear add queue
    var addqueue_queueName = UITextField()
    var addqueue_fromtime = UITextField()
    var addqueue_totime = UITextField()
    var addqueue_noofpersons = UITextField()
    var addqueue_clerklist = UI()
    
    func AppearAddQueue(parent:Any, runAfter:@escaping ()->Void) {
        self.parent = parent as! UIViewController

        let v = nibView(fileName: "addqueueNib", ownerClass: self) as! addqueueNib
        v.frame = (parent as! UIViewController).view.frame
        (parent as! UIViewController).view.addSubview(v)
        
        v.Input(any: parent) {
            runAfter()
        }
        self.nibview = v
        
        
    }
    
    func AppearDelQueue(parent:Any, savebtn:Selector,shopid:String,runAfter:@escaping ()-> Void) {
        self.parent = parent as! UIViewController

        let v = nibView(fileName: "delqueueNib", ownerClass: self) as! delqueueNib
        v.frame = (parent as! UIViewController).view.frame
        (parent as! UIViewController).view.addSubview(v)
        
        v.Input(any: parent as! UIViewController,
                saveBtn: savebtn,
                shopid: shopid){ runAfter() }
        
        self.nibview = v

    }
    
    
    
    
    func disAppear() {
        self.nibview.removeFromSuperview()
    }
    
    
    
}
