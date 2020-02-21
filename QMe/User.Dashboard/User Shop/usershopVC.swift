//
//  usershopVC.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/2/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

class usershopVC: UIViewController {

    
    
    
    
    //MARK:- IBoutlet
    @IBOutlet weak var shopname: UILabel!
    @IBOutlet weak var bodyscroll: UIScrollView!
    @IBOutlet var unassignedview: UIView!
    @IBOutlet weak var unassignedQueue: UILabel!
    @IBOutlet weak var followbtn: UIButton!
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if getBool(key: followbtnkey) {
            shopname.text = QueueListobj[0].shop_name
            followbtn.setTitle("Follow", for: .normal)
            apIobj.unAssignedQueue(any: self,shopId: QueueListobj[0].shop_id) {
                self.unassignedQueue.text = "\(unAssignedQueueList.count)"
            }
        }else{
            shopname.text = userShopListobj[Selectedshopindex].shop_name
            followbtn.setTitle("Unfollow", for: .normal)
            apIobj.unAssignedQueue(any: self,shopId: userShopListobj[Selectedshopindex].shop_id) {
                self.unassignedQueue.text = "\(unAssignedQueueList.count)"
            }
        }
        
        
        
        tableUI()
    }
    
    
    
    
    //MARK:- Table
    let table = UI()
    func tableUI(){
        table.TableView(x: 0, y: 0, width: x, height: y-bodyscroll.frame.minY, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), border: 0, borderColor: .clear, separatorColor: .clear, Sections: 1, SectionHeight: 0, SectionHEIGHT: {
        }, sectionView: {
        }, rows: QueueListobj.count, Rows: {
        }, editing: false, cellheight: 50, CellHeight: {
        }, Cellview: {
            self.cellview()
        }, onDelete: {
        }, view: bodyscroll)
        unassignedview.frame = CGRect(x: 0, y: table.table.frame.maxY, width: x, height: 30)
        bodyscroll.addSubview(unassignedview)
    }
    
    func cellview(){
        let cell = table.tableDelegate.cell
        let index = table.tableDelegate.index
        
        let cellview = nibView(fileName: "usershopcellNib", ownerClass: self) as! usershopcell
        cellview.frame = CGRect(x: 0, y: 0, width: x, height: cell.frame.size.height)
        cellview.layer.borderWidth = 0.5
        cellview.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.addSubview(cellview)
        
        table.table.frame.size.height = cell.frame.maxY
        unassignedview.frame.origin.y = cell.frame.maxY
        bodyscroll.contentSize.height = cell.frame.maxY+30
        
        cellview.Input(any: self,
                       QueueName: QueueListobj[index].queue_name,
                       QueueTotal: QueueListobj[index].queue_person,
                       AppointmentBtn: #selector(appointmentButton(_:)))
    }
    
    
    @objc func appointmentButton(_ btn:UIButton){
        
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
    
    @IBAction func backBtn(_ sender: UIButton) {
        sender.bouncybutton {
            self.dismiss(animated: false)
        }
    }
    
    
    @IBAction func notificationBtn(_ sender: UIButton) {
        sender.bouncybutton {
            self.present(storyboardView(boardName: "main", pageID: "notificationVC"), animated: false)
        }
    }
    
    
    
    @IBAction func followBTN(_ sender: UIButton) {
        sender.bouncybutton {
            if getBool(key: followbtnkey) {
                apIobj.followShopAPI(any: self,
                              UserID: getString(key: userIDkey),
                              shopId: QueueListobj[0].shop_id,
                              shopCode: QueueListobj[0].shop_code)
            }else{
                apIobj.unfollowShopAPI(any: self,
                                UserID: getString(key: userIDkey),
                                shopId: userShopListobj[Selectedshopindex].shop_id)
            }
        }
    }
    
}
