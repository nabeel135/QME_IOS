//
//  addnewshop.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/4/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit
import MTBBarcodeScanner
import Alamofire
import SwiftyJSON

class addnewshop: UIView {
   
    

    @IBOutlet weak var shopcode: UITextField!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var scannerview: UIView!
    var parent = UIViewController()
    var scanner: MTBBarcodeScanner?

    
    
    func Input(any:Any){
        self.parent = any as! UIViewController
        self.submit.addTarget(self, action: #selector(submitbtn), for: .touchUpInside)
        
        scannerUI()
    }
    
    
    @objc func submitbtn(_ btn:UIButton){
        btn.bouncybutton {
            popup.disAppear()
            if self.shopcode.text!.isEmpty {
                self.parent.showAlert(Title: "Error", Message: "Textfield Should not be Empty!")
            }
            else{
                self.shopdetailAPI(shopcode: self.shopcode.text!) {
                    save(value: true, key: followbtnkey)
                    self.parent.present(storyboardView(boardName: "main", pageID: "usershopVC"), animated: false)
                }
            }
        }
    }
    

    func scannerUI(){
        scannerview.frame.size.width = x-60
        scanner = MTBBarcodeScanner(previewView: scannerview)
        MTBBarcodeScanner.requestCameraPermission { success in
            if success {
                do{
                    try self.scanner?.startScanning(with: .back, resultBlock: { code in
                        if let code = code {
                            for obj in code {
                                let stringValue = obj.stringValue!
                                self.shopcode.text = stringValue
                                self.scanner?.stopScanning()
                            }
                        }
                    })
                }catch{NSLog("Unable to start scanning")}
            }
            else{self.parent.showAlert(Title: "Scanning Unavailable", Message: "This app does not have permission to access the camera")}
            
        }
    }
    
    
    
    
    // MARK:- API
    
    func shopdetailAPI(shopcode:String,runAfter:@escaping ()-> Void){
        self.parent.startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"queue_list_by_shopcode",
                                       "apikey":"mtechapi12345",
                                       "shop_code":shopcode],
                          headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseData
            { response in
                switch response.result {
                case .success(let data):
                    let d = JSON(data)
                    self.parent.stopLoader()
                    /*----------------*/
                    if d["success"].stringValue == "0" {
                        self.parent.showAlert(Title: "Error", Message: d["message"].stringValue)
                    }else{
                        QueueListobj.removeAll()
                        for obj in d["result"].arrayValue {
                            let o = QL()
                            o.admin_id = obj["store_admin"].stringValue
                            o.queue_id = obj["id"].stringValue
                            o.queue_name = obj["queue_name"].stringValue
                            o.queue_person = obj["number_of_persons"].stringValue
                            o.shop_id = obj["shop"].stringValue
                            o.shop_name = obj["shop_name"].stringValue
                            o.shop_code = obj["shop_code"].stringValue
                            o.clerk_id = obj["clerk"].stringValue
                            o.clerk_name = obj["clerk_name"].stringValue
                            o.fromTime = obj["opening_time"].stringValue
                            o.toTime = obj["closing_time"].stringValue
                            o.status = obj["status"].stringValue
                            QueueListobj.append(o)
                        }
                        runAfter()
                    }
                    /*----------------*/
                case .failure(let err):
                    self.parent.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    
    
    
}


