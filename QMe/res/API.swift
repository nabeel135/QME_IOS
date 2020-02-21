//
//  API.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/11/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


let apIobj = a()
class a {
    
    public func clerListAPI(any:UIViewController,runAfter:@escaping ()-> Void) {
        any.startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"clerk_list",
                                       "apikey":"mtechapi12345"],
                          headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseData { response in
                            switch(response.result){
                            case .success(let data):
                                let d = JSON(data)
                                any.stopLoader()
                                /*---------------------------*/
                                clerkListobj.removeAll()
                                clerkNamelist.removeAll()
                                for obj in d["result"].arrayValue {
                                    let o = CL()
                                    o.clerkId = obj["id"].stringValue
                                    o.clerkip = obj["ip"].stringValue
                                    o.name = obj["name"].stringValue
                                    clerkNamelist.append(obj["name"].stringValue)
                                    o.email = obj["email"].stringValue
                                    o.phone = obj["phone"].stringValue
                                    o.status = obj["status"].stringValue
                                    clerkListobj.append(o)
                                }
                                if clerkNamelist.count>0 {
                                    runAfter()
                                }
                                /*---------------------------*/
                            case .failure(let err):
                                any.showAlert(Title: "Error", Message: err.localizedDescription)
                            }
        }
    }
    
    
    
    
    
    
    func AddQueueAPI(any:UIViewController,adminId:String,shopId:String,shopCode:String,queueName:String,noOfpersons:String,clerkId:String,status:String,fromTime:String,toTime:String,runAfter:@escaping ()-> Void){
        any.startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"add_queue",
                                       "apikey":"mtechapi12345",
                                       "store_admin_id":adminId,
                                       "shop":shopId,
                                       "shop_code":shopCode,
                                       "queue_name":queueName,
                                       "number_of_persons":noOfpersons,
                                       "clerk":clerkId,
                                       "status":status,
                                       "opening_time":fromTime,
                                       "closing_time":toTime],
                          headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseData
            { response in
                switch response.result {
                case .success(let data):
                    let d = JSON(data)
                    any.stopLoader()
                    /*----------------------*/
                    any.showAlert(Title: "Message", Message: d["message"].stringValue)
                    runAfter()
                    /*----------------------*/
                case .failure(let err):
                    any.stopLoader()
                    any.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    func delQueueAPI(any:UIViewController,queueId:String,runAfter:@escaping ()-> Void){
        any.startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"delete_queue",
                                       "apikey":"mtechapi12345",
                                       "queue_id":queueId],
                          headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseData
            { response in
                switch response.result {
                case .success(let data):
                    let d = JSON(data)
                    /*----------------------------------*/
                    any.stopLoader()
                    runAfter()
                    any.showAlert(Title: "Message", Message: d["message"].stringValue)
                    /*----------------------------------*/
                case .failure(let err):
                    any.stopLoader()
                    any.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    
    
    
    
    
    
    func followShopAPI(any:UIViewController,UserID:String,shopId:String,shopCode:String){
        any.stopLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"follow_shop",
                                       "apikey":"mtechapi12345",
                                       "user_id":UserID,
                                       "shop_id":shopId,
                                       "shop_code":shopCode],
                          headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseData
            { response in
                switch response.result {
                case .success(let data):
                    let d = JSON(data)
                    any.stopLoader()
                    any.showAlert(Title: "Message", Message: d["message"].stringValue)
                case .failure(let err):
                    any.stopLoader()
                    any.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    
    func unfollowShopAPI(any:UIViewController,UserID:String,shopId:String){
        any.startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"unfollow",
                                       "apikey":"mtechapi12345",
                                       "user_id":UserID,
                                       "shop_id":shopId],
                          headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseData { response in
                            
                            switch response.result {
                            case .success(let data):
                                let d = JSON(data)
                                any.stopLoader()
                                any.showAlert(Title: "Message", Message: d["message"].stringValue)
                            case .failure(let err):
                                any.stopLoader()
                                any.showAlert(Title: "Error", Message: err.localizedDescription)
                            }
                            
        }
    }
    
    
    
    
    public func updateShopAPI(any:UIViewController,shopId:String,shopCode:String,shopName:String,shopimagURL:String,fromDay:String,toDay:String,fromTime:String,toTime:String,adminId:String,status:String){
        any.startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"update_shop",
                                       "apikey":"mtechapi12345",
                                       "shop_code":shopCode,
                                       "name":shopName,
                                       "store_admin":adminId,
                                       "image":shopimagURL,
                                       "opening_day":fromDay,
                                       "closing_day":toDay,
                                       "opening_time":fromTime,
                                       "closing_time":toTime,
                                       "status":status,
                                       "shop_id":shopId],
                          headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseData
            { response in
                switch response.result {
                case .success(let data):
                    let d = JSON(data)
                    any.stopLoader()
                    any.showAlert(Title: "Message", Message: d["message"].stringValue)
                case .failure(let err):
                    any.stopLoader()
                    any.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    
    
    
    
    
    func userNotificationAPI(any:UIViewController,userId:String,runAfter:@escaping()-> Void){
        db.jsonResponse(url: "http://172.104.217.178/qme/api/",
                        method: .post,
                        parameters: ["do":"notifications",
                                     "apikey":"mtechapi12345",
                                     "user_id":userId],
                        headers: ["Content-Type":"application/x-www-form-urlencoded"],
                        onStart: {
                            any.startLoader()
        }, onSuccess: {
            any.stopLoader()
            if db.json["success"].stringValue == "0" {
                any.showAlert(Title: "Message", Message: db.json["message"].stringValue)
            }else{
                notificationObj.removeAll()
                for obj in db.json["result"].arrayValue {
                    let o = N()
                    o.id = obj["id"].stringValue
                    o.userid = obj["user_id"].stringValue
                    o.shopid = obj["shop_id"].stringValue
                    o.message = obj["message"].stringValue
                    o.createdAt = obj["created_at"].stringValue
                    notificationObj.append(o)
                }
                runAfter()
            }
        }) {
            any.stopLoader()
            any.showAlert(Title: "Error", Message: db.err)
        }
    }
    
    
    
    func unAssignedQueue(any:UIViewController,shopId:String,runAfter:@escaping () -> Void){
        db.jsonResponse(url: "http://172.104.217.178/qme/api/",
                        method: .post,
                        parameters: ["do":"unassigned_queue_list",
                                     "apikey":"mtechapi12345",
                                     "shop_id":shopId],
                        headers: ["Content-Type":"application/x-www-form-urlencoded"],
                        onStart: {
                            any.startLoader()
        },
                        onSuccess: {
                            any.stopLoader()
                            if db.json["success"].stringValue == "0" {
//                                any.showAlert(Title: "unAssigned Queue", Message: db.json["message"].stringValue)
                            }
                            else{
                                unAssignedQueueList.removeAll()
                                for obj in db.json["result"].arrayValue {
                                    let o = UQL()
                                    o.queue_id = obj["id"].stringValue
                                    o.queue_name = obj["queue_name"].stringValue
                                    o.clerk_id = obj["clerk"].stringValue
                                    o.clerk_name = obj["clerk_name"].stringValue
                                    o.shop_id = obj["shop"].stringValue
                                    o.shop_name = obj["shop_name"].stringValue
                                    o.shop_code = obj["shop_code"].stringValue
                                    o.number_of_persons = obj["number_of_persons"].stringValue
                                    o.admin_id = obj["store_admin"].stringValue
                                    o.opening_time = obj["opening_time"].stringValue
                                    o.closing_time = obj["closing_time"].stringValue
                                    o.opening_day = obj["opening_day"].stringValue
                                    o.closing_day = obj["closing_day"].stringValue
                                    o.status = obj["status"].stringValue
                                    unAssignedQueueList.append(o)

                                }
                                runAfter()
                                
                            }
        },
                        onFailure: {
                            any.stopLoader()
        })
    }
    
}

