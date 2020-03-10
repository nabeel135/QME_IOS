//
//  clerkshopVC.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/2/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class clerkshopVC: UIViewController {

    
    
    // MARK:- API
    func clerkqueuelistAPI(shopid:String,clerkId:String){
        startLoader()
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
                    self.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    
    
    
    
    
    // MARK:- IBOutlet
    @IBOutlet weak var bodyview: UIView!
    @IBOutlet weak var shopname: UILabel!
    @IBOutlet weak var dayperiod: UILabel!
    @IBOutlet weak var timeperiod: UILabel!
    
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let obj = adminShopListobj[Selectedshopindex]
        self.shopname.text = obj.shop_name
        self.dayperiod.text = obj.fromday+"-"+obj.today
        self.timeperiod.text = obj.fromtime+"-"+obj.totime
        clerkqueuelistAPI(shopid: obj.shopid, clerkId: getString(key: userIDkey))
        
        
    }
    
    
    // MARK:- Table
    let table = UI()
    
    func tableUI(){
        table.TableView(x: 0, y: 0, width: x, height: y-bodyview.frame.minY, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), border: 0, borderColor: .clear, separatorColor: .clear, Sections: 1, SectionHeight: 0, SectionHEIGHT: {
        }, sectionView: {
        }, rows: QueueListobj.count, Rows: {
        }, editing: false, cellheight: 50, CellHeight: {
        }, Cellview: {
            self.cellview()
        }, onDelete: {
        }, view: bodyview)
    }
    
    func cellview(){
        let cell = table.tableDelegate.cell
        let index = table.tableDelegate.index
        
        let cellview = nibView(fileName: "adminshopcellNib", ownerClass: self) as! adminshopcell
        cellview.frame = CGRect(x: 0, y: 0, width: x, height: 50)
        cellview.layer.borderWidth = 0.5
        cellview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.addSubview(cellview)
        
        let obj = QueueListobj[index]
        cellview.Input(any: self,
                       queueid: obj.queue_id,
                       queueName: obj.queue_name,
                       timePeriod: obj.fromTime+"-"+obj.toTime,
                       no_of_persons: obj.queue_person,
                       status: obj.status, last: false)
    }
    
    
    
    
    // MARK:- Buttons
    
    @IBAction func dayperiodBtn(_ sender: UIButton) {
        sender.bouncybutton {
            popup.Appeardayperiodpicker(parent: self, label: self.dayperiod)
        }
    }
    
    @IBAction func timeperiodBtn(_ sender: UIButton) {
        sender.bouncybutton {
            popup.Appeartimeperiodpicker(parent: self, label: self.timeperiod)
        }
    }
    
    @IBAction func backBUTTON(_ sender: UIButton) {
        sender.bouncybutton {
            self.dismiss(animated: false)
        }
    }
    
    @IBAction func menuBUTTON(_ sender: UIButton) {
        menubar.AppearUserMenu(parent: self,
                               ProfileName: getString(key: userNamekey),
                               DashboardBtn: #selector(self.dashboardBUTTON),
                               editBtn: #selector(self.editprofiepage),
                               logoutBtn: #selector(self.logoutBUTTON),
                               inView: self.view)
    }
    
    
    
    @objc func dashboardBUTTON(_ btn:UIButton){
        btn.bouncybutton {
            menubar.disAppear()
        }
    }
    @objc func editprofiepage(_ btn:UIButton){
        btn.bouncybutton {
            menubar.disAppear()
            self.present(storyboardView(boardName: "main", pageID: "editprofileVC"), animated: true)
        }
    }
    @objc func logoutBUTTON(_ btn:UIButton){
        btn.bouncybutton {
            menubar.disAppear()
            save(value: false, key: logedinkey)
            self.present(storyboardView(boardName: "main", pageID: "loginVC"), animated: false)
        }
    }
    
    
    
}
