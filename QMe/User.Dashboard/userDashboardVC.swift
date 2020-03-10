//
//  userDashboardVC.swift
//  QMe
//
//  Created by Mr. Nabeel on 1/31/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class userDashboardVC: UIViewController {
    
    // MARK:- API
    func userShoplistAPI(userid:String){
        startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"user_shops",
                                       "apikey":"mtechapi12345",
                                       "user_id":userid],
                          headers: ["":""]).responseData
            { response in
                switch response.result {
                case .success(let data):
                    let d = JSON(data)
                    self.stopLoader()
                    /*-------------------*/
                    userShopListobj.removeAll()
                    if d["success"].stringValue == "0" {
                        self.showAlert(Title: "Error", Message: d["message"].stringValue)
                    }else{
                        for obj in d["result"].arrayValue {
                            let o = USL()
                            o.shop_id = obj["id"].stringValue
                            o.shop_code = obj["shop_code"].stringValue
                            o.shop_name = obj["name"].stringValue
                            o.queue_count = obj["queues_count"].stringValue
                            o.admin_id = obj["store_admin"].stringValue
                            o.admin_name = obj["admin_name"].stringValue
                            o.image = obj["image"].stringValue
                            o.fromDay = obj["opening_day"].stringValue
                            o.toDay = obj["closing_day"].stringValue
                            o.fromTime = obj["opening_time"].stringValue
                            o.toTime = obj["closing_time"].stringValue
                            o.status = obj["status"].stringValue
                            userShopListobj.append(o)
                        }
                    }
                    
                    
                    /*-------------------*/
                    self.tableUI()
                case .failure(let err):
                    self.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    
    // MARK:- API
    
    func queueListAPI(shopcode:String,runAfter:@escaping ()-> Void){
        self.startLoader()
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
                    self.stopLoader()
                    /*----------------*/
                    if d["success"].stringValue == "0" {
                        QueueListobj.removeAll()
                        runAfter()
                        self.showAlert(Title: "Error", Message: d["message"].stringValue)
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
                    self.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    
    
    
    
    //MARK:- IBoutlet
    @IBOutlet weak var header: UIView!
    @IBOutlet var addview: UIView!
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        userShoplistAPI(userid: getString(key: userIDkey))
    }
    
    
    
    //MARK:- Table
    let table = UI()
    func tableUI(){
        table.TableView(x: 0, y: 120, width: x, height: y-150, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), border: 0, borderColor: .clear, separatorColor: .clear, Sections: 1, SectionHeight: 0, SectionHEIGHT: {
        }, sectionView: {
        }, rows: userShopListobj.count, Rows: {
        }, editing: false, cellheight: 50, CellHeight: {
        }, Cellview: {
            self.cellview()
        }, onDelete: {
        }, view: view)
        
        // add new shop view
        addview.frame = CGRect(x: x-130, y: y-80, width: 100, height: 80)
        view.addSubview(addview)
        table.table.reloadData()
    }
    
    
    func cellview(){
        let cell = self.table.tableDelegate.cell
        let index = self.table.tableDelegate.index
        
        let cellview = nibView(fileName: "usercellNib", ownerClass: self) as! usercell
        cellview.frame = CGRect(x: 0, y: 0, width: x, height: 50)
        cellview.layer.borderWidth = 0.5
        cellview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.addSubview(cellview)
        
        cellview.Input(ShopName: userShopListobj[index].shop_name,
                       QueueTotal: userShopListobj[index].queue_count)
        cellview.tag = index
        cellview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openShoppage(_:))))
        
    }
    
    
    @objc func openShoppage(_ tap:UITapGestureRecognizer){
        Selectedshopindex = tap.view!.tag
        queueListAPI(shopcode: userShopListobj[Selectedshopindex].shop_code) {
            save(value: false, key: followbtnkey)
            self.present(storyboardView(boardName: "main", pageID: "usershopVC"), animated: false)
        }
    }
    
    
    
    
    
    
    
    //MARK:- Buttons
    @IBAction func menuBtn(_ sender: UIButton) {
        sender.bouncybutton {
            menubar.AppearUserMenu(parent: self,
                                   ProfileName: getString(key: userNamekey),
                                   DashboardBtn: #selector(self.dashboardBtn),
                                   editBtn: #selector(self.editprofiepage),
                                   logoutBtn: #selector(self.logoutBUTTON),
                                   inView: self.view)
        }
    }
    
    @objc func dashboardBtn(_ btn:UIButton){
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
    
    
    @IBAction func addShopButton(_ sender: UIButton) {
        sender.bouncybutton {
            popup.AppearAddnewShop(parent: self)
        }
    }
        
    
}
