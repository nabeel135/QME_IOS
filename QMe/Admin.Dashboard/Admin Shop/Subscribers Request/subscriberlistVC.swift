//
//  subscriberlistVC.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/2/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class subscriberlistVC: UIViewController {
    
    // MARK:- API
    
    func requestListAPI(adminID:String){
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"requests",
                                       "apikey":"mtechapi12345",
                                       "admin_id":adminID],
                          headers: ["":""]).responseData
            { response in
                switch response.result {
                case .success(let data):
                    let d = JSON(data)
                    /*---------------------*/
                    if d["success"].stringValue == "0" {
                        self.showAlert(Title: "Error", Message: d["message"].stringValue)
                    }else{
                        adminrequestlistobj.removeAll()
                        for obj in d["result"].array! {
                            if obj["follow_status"].stringValue == "Pending" && obj["shop_code"].stringValue == adminShopListobj[Selectedshopindex].shop_code {
                                let o = ARL()
                                o.userimag = "http://172.104.217.178/qme/files/"+obj["follow_by_image"].stringValue
                                o.userid = obj["follow_id"].stringValue
                                o.userName = obj["follow_by"].stringValue
                                adminrequestlistobj.append(o)
                            }
                            

                        }
                        self.tableUI()
                        self.table.table.reloadData()
                    }
                    /*---------------------*/
                case .failure(let err):
                    self.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    
    func AcceptRequestAPI(id:String){
        startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"accept_request",
                                       "apikey":"mtechapi12345",
                                       "id":id],
                          headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseData
            { response in
                switch(response.result){
                case .success(let data):
                    let d = JSON(data)
                    self.stopLoader()
                    /*--------------------*/
                    self.showAlert(Title: "Message", Message: d["message"].stringValue)
                    self.requestListAPI(adminID: getString(key: userIDkey))
                    /*--------------------*/
                case .failure(let err):
                    self.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    
    func RejectRequestAPI(id:String){
        startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"reject_request",
                                       "apikey":"mtechapi12345",
                                       "id":id],
                          headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseData
            { response in
                switch(response.result){
                case .success(let data):
                    let d = JSON(data)
                    self.stopLoader()
                    /*--------------------*/
                    self.showAlert(Title: "Message", Message: d["message"].stringValue)
                    self.requestListAPI(adminID: getString(key: userIDkey))
                    /*--------------------*/
                case .failure(let err):
                    self.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    
    
    // MARK:- IBoutlet
    @IBOutlet weak var bodyview: UIView!
    
    
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestListAPI(adminID: getString(key: userIDkey))
        
    }
    
    
    // MARK:- table
    let table = UI()
    
    func tableUI(){
        table.TableView(x: 0, y: 0, width: x, height: y-bodyview.frame.minY, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), border: 0, borderColor: .clear, separatorColor: .clear, Sections: 1, SectionHeight: 0, SectionHEIGHT: {
        }, sectionView: {
        }, rows: adminrequestlistobj.count, Rows: {
        }, editing: false, cellheight: 110, CellHeight: {
        }, Cellview: {
            self.cellview()
        }, onDelete: {
        }, view: bodyview)
    }
    
    func cellview(){
        let cell = table.tableDelegate.cell
        let index = table.tableDelegate.index
        
        let cellview = nibView(fileName: "requestcellNib",ownerClass: self) as! requestcell
        cellview.frame = CGRect(x: 0, y: 0, width: x, height: 110)
        cell.addSubview(cellview)
        cellview.acceptbtn.tag = adminrequestlistobj[index].userid.toInt()
        cellview.denybtn.tag = adminrequestlistobj[index].userid.toInt()
        cellview.Input(any: self,
                       profilepic: adminrequestlistobj[index].userimag,
                       username: adminrequestlistobj[index].userName,
                       acceptBtn: #selector(acceptrequestBtn(_:)),
                       denyBtn: #selector(denyrequestBtn(_:)))
        
    }
    
    
    
    
    
    
    // MARK:- Buttons
    
    @objc func acceptrequestBtn(_ btn:UIButton){
        AcceptRequestAPI(id: btn.tag.tostring())
    }
    
    @objc func denyrequestBtn(_ btn:UIButton){
        RejectRequestAPI(id: btn.tag.tostring())
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        sender.bouncybutton {
            self.dismiss(animated: false)
        }
    }
    
    @IBAction func MenuBtn(_ sender: UIButton) {
        sender.bouncybutton {
            menubar.AppearAdminMenu(parent: self,
                                    ProfileName: getString(key: userNamekey),
                                    DashboardBtn: #selector(self.dashboardBUTTON),
                                    editBtn: #selector(self.editprofiepage),
                                    loginasclerkBtn: #selector(self.logoutBUTTON),
                                    logoutBtn: #selector(self.logoutBUTTON),
                                    inView: self.view)
        }
    }
    
    @objc func dashboardBUTTON(btn:UIButton){
        btn.bouncybutton {
            menubar.disAppear()
        }
    }
    @objc func editprofiepage(btn:UIButton){
        btn.bouncybutton {
            menubar.disAppear()
            self.present(storyboardView(boardName: "main", pageID: "editprofileVC"), animated: true)
        }
    }
    @objc func logoutBUTTON(btn:UIButton){
        btn.bouncybutton {
            menubar.disAppear()
            save(value: false, key: logedinkey)
            self.present(storyboardView(boardName: "main", pageID: "loginVC"), animated: false)
        }
    }
    
    
}
