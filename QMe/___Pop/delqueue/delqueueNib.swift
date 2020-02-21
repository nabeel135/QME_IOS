//
//  delqueueNib.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/11/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class delqueueNib: UIView {

    @IBOutlet weak var bodyview: UIView!
    @IBOutlet weak var savebtn: UIButton!
    let table = UI()
    var parent = UIViewController()
    var runafter:()->Void = {}
    
    func Input(any:UIViewController,saveBtn:Selector,shopid:String,runAfter:@escaping ()-> Void){
        parent = any
        self.runafter = runAfter
        
        
        if getString(key: accTypekey) == "Clerk" {
            clerkqueuelistAPI(any: self.parent, shopid: shopid, clerkId: getString(key: userIDkey))
        }
        else{
            adminqueuelistAPI(any: self.parent, shopid: shopid)
        }
        
        self.savebtn.addTarget(any, action: saveBtn, for: .touchUpInside)
    }
    
    
    
    
    func tableUI(){
        table.TableView(x: 10, y: 60, width: x-120, height: bodyview.frame.size.height-110, bkcolor: .clear, border: 0, borderColor: .clear, separatorColor: .clear, Sections: 1, SectionHeight: 0, SectionHEIGHT: {
        }, sectionView: {
        }, rows: QueueListobj.count, Rows: {
        }, editing: false, cellheight: 40, CellHeight: {
        }, Cellview: {
            self.cellview()
        }, onDelete: {
        }, view: bodyview)
        table.table.reloadData()
    }
    
    func cellview(){
        let cell = table.tableDelegate.cell
        let index = table.tableDelegate.index
        
        let cellview = nibView(fileName: "delqueuecellNib", ownerClass: self) as! delqueueCell
        cellview.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: 40)
        cell.addSubview(cellview)
        
        
        let obj = QueueListobj[index]
        
        
        cellview.delbtn.tag = index
        cellview.Input(any: self,
                       queueName: obj.queue_name,
                       timePeriod: "(\(obj.fromTime)-\(obj.toTime))",
            delBtn: #selector(delqueue(_:)))
        
    }
    
    @objc func delqueue(_ btn:UIButton){
        btn.bouncybutton {
            apIobj.delQueueAPI(any: self.parent, queueId: QueueListobj[btn.tag].queue_id) {
                self.runafter()
            }
            QueueListobj.remove(at: btn.tag)
            self.tableUI()
        }
    }
    
    
    
    // MARK:- API
    func adminqueuelistAPI(any:UIViewController,shopid:String){
        parent.startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"queue_list",
                                       "apikey":"mtechapi12345",
                                       "shop_id":shopid],
                          headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseData
            { response in
                switch response.result {
                case .success(let data):
                    let d = JSON(data)
                    self.parent.stopLoader()
                    /*---------------------*/
                    if d["success"].stringValue == "0" {
                        self.parent.showAlert(Title: "Error", Message: d["message"].stringValue)
                    }
                    else{
                        QueueListobj.removeAll()
                        for obj in d["result"].arrayValue {
                            let o = QL()
                            o.admin_id = obj["store_admin"].stringValue
                            o.clerk_id = obj["clerk"].stringValue
                            o.clerk_name = obj["clerk_name"].stringValue
                            o.queue_id = obj["id"].stringValue
                            o.queue_name = obj["queue_name"].stringValue
                            o.queue_person = obj["number_of_persons"].stringValue
                            o.shop_id = obj["shop"].stringValue
                            o.shop_name = obj["shop_name"].stringValue
                            o.shop_code = obj["shop_code"].stringValue
                            o.status = obj["status"].stringValue
                            o.fromTime = obj["opening_time"].stringValue
                            o.toTime = obj["closing_time"].stringValue
                            QueueListobj.append(o)
                        }
                        self.tableUI()
                    }
                    /*---------------------*/
                case .failure(let err):
                    self.parent.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    
    
    func clerkqueuelistAPI(any:UIViewController,shopid:String,clerkId:String){
        any.startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"clerk_queue_list",
                                       "apikey":"mtechapi12345",
                                       "shop_id":shopid,
                                       "clerk_id":clerkId],
                          headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseData
            { response in
                switch response.result {
                case .success(let data):
                    let d = JSON(data)
                    any.stopLoader()
                    /*---------------------*/
                    if d["success"].stringValue == "0" {
                        any.showAlert(Title: "Error", Message: d["message"].stringValue)
                    }
                    else{
                        QueueListobj.removeAll()
                        for obj in d["result"].arrayValue {
                            let o = QL()
                            o.admin_id = obj["store_admin"].stringValue
                            o.queue_id = obj["id"].stringValue
                            o.queue_name = obj["queue_name"].stringValue
                            o.clerk_id = obj["clerk"].stringValue
                            o.clerk_name = obj["clerk_name"].stringValue
                            o.queue_person = obj["number_of_persons"].stringValue
                            o.shop_id = obj["shop"].stringValue
                            o.shop_name = obj["shop_name"].stringValue
                            o.shop_code = obj["shop_code"].stringValue
                            o.status = obj["status"].stringValue
                            o.fromTime = obj["opening_time"].stringValue
                            o.toTime = obj["closing_time"].stringValue
                            QueueListobj.append(o)
                        }
                        self.tableUI()
                    }
                    /*---------------------*/
                case .failure(let err):
                    any.stopLoader()
                    any.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
}
