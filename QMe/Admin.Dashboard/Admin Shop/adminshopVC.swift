//
//  adminshopVC.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/2/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON

class adminshopVC: UIViewController {
    
    // MARK:- API
    func adminqueuelistAPI(shopid:String){
        startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"queue_list",
                                       "apikey":"mtechapi12345",
                                       "shop_id":shopid],
                          headers: ["":""]).responseData
            { response in
                switch response.result {
                case .success(let data):
                    let d = JSON(data)
                    self.stopLoader()
                    /*---------------------*/
                    if d["success"].stringValue == "0" {
                        self.showAlert(Title: "Error", Message: d["message"].stringValue)
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
                    self.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    
    
    
    // MARK:- IBOutlet
    let bodyscroll = UI()
    @IBOutlet weak var bodyview: UIView!
    @IBOutlet weak var section: UIView!
    
    @IBOutlet weak var shopname: UILabel!
    @IBOutlet weak var timeperiod: UILabel!
    
    @IBOutlet weak var shopSwitch: UISwitch!
    @IBOutlet weak var shopcode: UILabel!
    @IBOutlet weak var QRcode: UIImageView!
    
    @IBOutlet weak var editshopbtn: UIButton!
    @IBOutlet weak var requestbtn: UIButton!
    
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        bodyscroll.ScrollView(x: 0, y: 70, width: x, height: y-70, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), contentwidth: x, contentheight: y-70, view: view)
        
        bodyview.frame = CGRect(x: 0, y: 0, width: x, height: 334)
        bodyscroll.scrollview.addSubview(bodyview)
        

    }
    
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        
        let obj = adminShopListobj[Selectedshopindex]
        shopname.text = obj.shop_name
        shopcode.text = obj.shop_code
        QRcode.image = obj.shop_code.toQRImage()
        timeperiod.text = obj.fromtime+"-"+obj.totime
        if obj.status == "Active" {self.shopSwitch.isOn = true}
        else{self.shopSwitch.isOn = false}
        
        if getString(key: accTypekey) == "Clerk" {
            print("clerk queue list")
        }
        else{
            adminqueuelistAPI(shopid: obj.shopid)
        }

    }
    
    // MARK:- Table
    let table = UI()
    
    func tableUI(){
        table.TableView(x: 0, y: section.frame.maxY, width: x, height: y-70-bodyview.frame.size.height, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), border: 0, borderColor: .clear, separatorColor: .clear, Sections: 1, SectionHeight: 0, SectionHEIGHT: {
        }, sectionView: {
        }, rows: QueueListobj.count+1, Rows: {
        }, editing: false, cellheight: 50, CellHeight: {
        }, Cellview: {
            self.cellview()
        }, onDelete: {
        }, view: bodyscroll.scrollview)
        bodyscroll.scrollview.contentSize.height = table.table.frame.maxY
        table.table.reloadData()
    }
    
    func cellview(){
        let cell = table.tableDelegate.cell
        let index = table.tableDelegate.index
        
        let cellview = nibView(fileName: "adminshopcellNib", ownerClass: self) as! adminshopcell
        cellview.frame = CGRect(x: 0, y: 0, width: x, height: 50)
        cellview.layer.borderWidth = 0.5
        cellview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.addSubview(cellview)
        
        if index == QueueListobj.count {
            cellview.addperson.isHidden = true
            cellview.subtractperson.isHidden = true
            cellview.switchbtn.isHidden = true
            cellview.Input(
            any: self,
            queueid: "",
            queueName: "Unassigned Queue",
            timePeriod: "",
            no_of_persons: "\(unAssignedQueueList.count)",
                status: "",
                last: true)
            
        }
        else{
            let obj = QueueListobj[index]
            cellview.Input(any: self,
                           queueid: obj.queue_id,
                           queueName: obj.queue_name,
                           timePeriod: obj.fromTime+"-"+obj.toTime,
                           no_of_persons: obj.queue_person,
                           status: obj.status, last: false)
        }
    }
    
    
    // MARK:- Buttons
    @IBAction func backBUTTON(_ sender: UIButton) {
        sender.bouncybutton {
            self.dismiss(animated: false)
        }
    }
    
    @IBAction func requestBtn(_ sender: UIButton) {
        sender.bouncybutton {
            self.present(storyboardView(boardName: "main", pageID: "subscriberlistVC"), animated: false)
        }
    }
    
    
    @IBAction func edittimepriod(_ sender: UIButton) {
        sender.bouncybutton {
            popup.Appeartimeperiodpicker(parent: self, label: self.timeperiod)
        }
    }
    
    
    @IBAction func shareShopCodeBtn(_ sender: UIButton) {
        sender.bouncybutton {
            self.shareOnSocialMedia(Content: ["Shop Name: \(adminShopListobj[Selectedshopindex].shop_name)",
            "Shop Code: \(adminShopListobj[Selectedshopindex].shop_code)"], ONsuccess: {
                self.showAlert(Title: "Success", Message: "Successfully shared")
            }, ONfail: {
                self.showAlert(Title: "Error", Message: "failed to Share")
            })
        }
        
    }
    
    @IBAction func shareShopQRcodeBtn(_ sender: UIButton) {
        sender.bouncybutton {
            self.shareOnSocialMedia(Content: ["Shop Name: \(adminShopListobj[Selectedshopindex].shop_name)","Shop Code: \(adminShopListobj[Selectedshopindex].shop_code)",self.QRcode.image!], ONsuccess: {
                self.showAlert(Title: "Success", Message: "Successfully shared")
            }, ONfail: {
                self.showAlert(Title: "Error", Message: "failed to Share")
            })
        }
        
        
    }
    
    @IBAction func shopSwitch(_ sender: UIButton) {
        sender.bouncybutton {
            var status = "Active"
            if self.shopSwitch.isOn {status = "Active"}
            else{status = "Inactive"}
            let obj = adminShopListobj[Selectedshopindex]
            apIobj.updateShopAPI(any: self,
                                 shopId: obj.shopid,
                                 shopCode: obj.shop_code,
                                 shopName: obj.shop_name,
                                 shopimagURL: obj.shopimag,
                                 fromDay: obj.fromday,
                                 toDay: obj.today,
                                 fromTime: obj.fromtime,
                                 toTime: obj.totime,
                                 adminId: obj.admin_id,
                                 status: status)
            obj.status = status
        }
    }
    
    @IBAction func menuBtn(_ sender: UIButton) {
        sender.bouncybutton {
            if getString(key: accTypekey) == "Clerk" {
                menubar.AppearUserMenu(parent: self,
                                       ProfileName: getString(key: userNamekey),
                                       DashboardBtn: #selector(self.dashboardBUTTON),
                                       editBtn: #selector(self.editprofiepage),
                                       logoutBtn: #selector(self.logoutBUTTON),
                                       inView: self.view)
            }
            else{
                menubar.AppearAdminMenu(parent: self,
                                        ProfileName: getString(key: userNamekey),
                                        DashboardBtn: #selector(self.dashboardBUTTON),
                                        editBtn: #selector(self.editprofiepage),
                                        loginasclerkBtn: #selector(self.loginAsClerk),
                                        logoutBtn: #selector(self.logoutBUTTON),
                                        inView: self.view)
            }
        }
    }
    
    
    
    @objc func dashboardBUTTON(){
        menubar.disAppear()
    }
    @objc func editprofiepage(){
        menubar.disAppear()
        self.present(storyboardView(boardName: "main", pageID: "editprofileVC"), animated: true)
    }
    @objc func loginAsClerk(){
        menubar.disAppear()
        save(value: false, key: logedinkey)
        save(value: "Login As Clerk", key: loginAstitle)
        self.present(storyboardView(boardName: "main", pageID: "loginVC"), animated: false)
    }
    @objc func logoutBUTTON(){
        menubar.disAppear()
        save(value: false, key: logedinkey)
        self.present(storyboardView(boardName: "main", pageID: "loginVC"), animated: false)
    }
    
    @IBAction func editShop(_ sender: UIButton) {
        sender.bouncybutton {
            self.present(storyboardView(boardName: "main", pageID: "shopupdateVC"), animated: false)
        }
    }
    
    
    
    
    
    
    
}


















