//
//  notificationVC.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/12/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

class notificationVC: UIViewController {

    
    @IBOutlet weak var notititle: UILabel!
    
    // MARK:- View did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        apIobj.userNotificationAPI(any: self, userId: getString(key: userIDkey)){
            self.tableUI()
        }
    }
    
    
    
    let table = UI()
    
    func tableUI(){
        table.TableView(x: 0, y: notititle.frame.maxY+5, width: x, height: y-notititle.frame.maxY-20, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), border: 0, borderColor: .clear, separatorColor: .clear, Sections: 1, SectionHeight: 0, SectionHEIGHT: {
        }, sectionView: {
        }, rows: notificationObj.count, Rows: {
        }, editing: false, cellheight: 80, CellHeight: {
        }, Cellview: {
            self.cellview()
        }, onDelete: {
        }, view: view)
    }
    
    func cellview(){
        let cell = table.tableDelegate.cell
        let index = table.tableDelegate.index
        
        let cellview = nibView(fileName: "notificationcellNib", ownerClass: self) as! notificationCellNib
        cellview.frame = CGRect(x: 0, y: 0, width: x, height: 80)
        cell.addSubview(cellview)
        let obj = notificationObj[index]
        cellview.Input(message: "\(obj.createdAt) \n \(obj.message)")
    }
    

   // MARK:- Buttons
    @IBAction func menubtn(_ sender: UIButton) {
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
    
    
    
    @IBAction func back(_ sender: UIButton) {
        sender.bouncybutton {
            self.dismiss(animated: false)
        }
    }
    
    
}
