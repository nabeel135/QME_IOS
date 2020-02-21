//
//  adminshopcell.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/2/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class adminshopcell: UIView {
    
    @IBOutlet weak var queuename: UILabel!
    @IBOutlet weak var switchbtn: UISwitch!
    @IBOutlet weak var person_no: UITextField!
    @IBOutlet weak var addperson: UIButton!
    @IBOutlet weak var subtractperson: UIButton!
    @IBOutlet weak var timeperiod: UILabel!
    private var parent:Any!
    
    func Input(any:Any,queueid:String, queueName:String,timePeriod:String,no_of_persons:String,status:String,last:Bool){
        
        parent = any
        if status == "Active" {switchbtn.isOn = true}
        else{switchbtn.isOn = false}
        
        switchbtn.tag = queueid.toInt()
        self.queuename.text = queueName
        self.timeperiod.text = timePeriod
        
        if no_of_persons == "" {
            self.person_no.text = "0"}
        else{self.person_no.text = no_of_persons}
        
        
        addperson.tag = queueid.toInt()
        subtractperson.tag = queueid.toInt()
        
        if last {
            apIobj.unAssignedQueue(any: any as! UIViewController, shopId: adminShopListobj[Selectedshopindex].shopid) {
                self.person_no.text = "\(unAssignedQueueList.count)"
            }
        }
        
        
        
        
        self.addperson.addTarget(self, action: #selector(addperson(_:)), for: .touchUpInside)
        self.subtractperson.addTarget(self, action: #selector(subtractperson(_:)), for: .touchUpInside)
    }
    
    
    
    @objc func addperson(_ btn:UIButton){
        self.person_no.text = String(person_no.text!.toInt()+1)
        self.updatequeuePersonAPI(queueID: btn.tag.tostring(), noOfpersons: self.person_no.text!)
    }
    
    @objc func subtractperson(_ btn:UIButton){
        self.person_no.text = String(person_no.text!.toInt() - 1)
        self.updatequeuePersonAPI(queueID: btn.tag.tostring(), noOfpersons: self.person_no.text!)
    }
    
    
    
    
    @IBAction func queueSwitch(_ sender: UISwitch) {
        var Status = "Active"
        
        if sender.isOn {Status = "Active"}
        else{Status = "Inactive"}
        
        let obj = adminShopListobj[Selectedshopindex]
        let q = QueueListobj.filter{$0.queue_id == sender.tag.tostring()}.first!
        updateQueueAPI(adminID: getString(key: userIDkey),
                       shopID: obj.shopid,
                       shopName: obj.shop_name,
                       queueName: q.queue_name,
                       queuePersons: q.queue_person,
                       clerkID: q.clerk_id,
                       clerkName: q.clerk_name,
                       status: Status,
                       queueID: sender.tag.tostring(),
                       fromTime: q.fromTime,
                       toTime: q.toTime)
    }
    
    
    
    
    func updatequeuePersonAPI(queueID:String,noOfpersons:String){
        (self.parent as! UIViewController).startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"update_queue_person",
                                       "apikey":"mtechapi12345",
                                       "queue_id":queueID,
                                       "number_of_persons":noOfpersons],
                          headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseData
            { response in
                switch response.result{
                case .success(let data):
                    let d = JSON(data)
                    (self.parent as! UIViewController).stopLoader()
                    /*--------------------------*/
//                    (self.parent as! UIViewController).showAlert(Title: "Message", Message: d["message"].stringValue)
                    /*--------------------------*/
                case .failure(let err):
                    (self.parent as! UIViewController).stopLoader()
                    (self.parent as! UIViewController).showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    
    
    func updateQueueAPI(adminID:String,shopID:String,shopName:String,queueName:String,queuePersons:String,clerkID:String,clerkName:String,status:String,queueID:String,fromTime:String,toTime:String){
        (parent as! UIViewController).startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"update_queue",
                                       "apikey":"mtechapi12345",
                                       "store_admin_id":adminID,
                                       "shop":shopID,
                                       "shop_name":shopName,
                                       "queue_name":queueName,
                                       "number_of_persons":queuePersons,
                                       "clerk":clerkID,
                                       "clerk_name":clerkName,
                                       "status":status,
                                       "queue_id":queueID,
                                       "opening_time":fromTime,
                                       "closing_time":toTime],
                          headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseData
            { response in
                switch response.result {
                case .success(let data):
                    let d = JSON(data)
                    /*------------------------*/
                    (self.parent as! UIViewController).stopLoader()
                    if d["success"].stringValue == "1" {
                        (self.parent as! UIViewController).showAlert(Title: "Success", Message: d["message"].stringValue)
                    }
                    /*------------------------*/
                    
                case .failure(let err):
                    (self.parent as! UIViewController).stopLoader()
                    (self.parent as! UIViewController).showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }}
    
    
}
