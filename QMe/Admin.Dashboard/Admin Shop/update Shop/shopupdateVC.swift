//
//  shopupdateVC.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/12/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

class shopupdateVC: UIViewController {

    //MARK:- IBoutlet
    
    @IBOutlet weak var shopcode: UITextField!
    @IBOutlet weak var shopname: UITextField!
    @IBOutlet weak var fromday: UITextField!
    @IBOutlet weak var today: UITextField!
    @IBOutlet weak var fromtime: UITextField!
    @IBOutlet weak var totime: UITextField!
    let status = UI()
    
    @IBOutlet weak var bodyview: UIView!
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        status.ComboBox(["Active","Inactive"], 0, x: 100, y: fromtime.frame.maxY+10, width: 150, height: 35, bkcolor: #colorLiteral(red: 0.2165208161, green: 0.2892589867, blue: 0.3608489335, alpha: 0.4), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cornerRadius: 5, editable: false, placeholder: "chosse status", fontsize: 12, iconColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), listbkcolor: #colorLiteral(red: 0.2165208161, green: 0.2892589867, blue: 0.3608489335, alpha: 0.1), listTextcolor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), view: self.bodyview) {
        }
        
        shopcode.text = adminShopListobj[Selectedshopindex].shop_code
        shopname.text = adminShopListobj[Selectedshopindex].shop_name
        fromday.text = adminShopListobj[Selectedshopindex].fromday
        today.text = adminShopListobj[Selectedshopindex].today
        fromtime.text = adminShopListobj[Selectedshopindex].fromtime
        totime.text = adminShopListobj[Selectedshopindex].totime
        
    }
    

    
    
    // MARK:- Buttons
    @IBAction func back(_ sender: UIButton) {
        sender.bouncybutton {
            self.dismiss(animated: false)
        }
    }
    
    @IBAction func save(_ sender: UIButton) {
        sender.bouncybutton {
            if self.validation() {
                apIobj.updateShopAPI(any: self,
                              shopId: adminShopListobj[Selectedshopindex].shopid,
                              shopCode: self.shopcode.text!,
                              shopName: self.shopname.text!,
                              shopimagURL: adminShopListobj[Selectedshopindex].shopimag,
                              fromDay: self.fromday.text!,
                              toDay: self.today.text!,
                              fromTime: self.fromtime.text!,
                              toTime: self.totime.text!,
                              adminId: adminShopListobj[Selectedshopindex].admin_id,
                              status: self.status.comboBox.text_comboBox())
                
                let obj = adminShopListobj[Selectedshopindex]
                obj.shop_code = self.shopcode.text!
                obj.shop_name = self.shopname.text!
                obj.fromday = self.fromday.text!
                obj.today = self.today.text!
                obj.fromtime = self.fromtime.text!
                obj.totime = self.totime.text!
                obj.status = self.status.comboBox.text_comboBox()
            }
        }
    }
    
    func validation()-> Bool{
        if shopcode.text!.isEmpty || shopname.text!.isEmpty || fromday.text!.isEmpty || today.text!.isEmpty || fromtime.text!.isEmpty || totime.text!.isEmpty {
            self.showAlert(Title: "Error", Message: "Textfiled should not be Empty!")
            return false
        }
        else{
            return true
        }
    }
    
    
    @IBAction func menubtn(_ sender: UIButton) {
        sender.bouncybutton {
            menubar.AppearAdminMenu(parent: self,
                                    ProfileName: getString(key: userNamekey),
                                    DashboardBtn: #selector(self.dashboardBUTTON),
                                    editBtn: #selector(self.editprofiepage),
                                    loginasclerkBtn: #selector(self.loginAsClerk),
                                    logoutBtn: #selector(self.logoutBUTTON),
                                    inView: self.view)
        }
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
    @objc func loginAsClerk(_ btn:UIButton){
        btn.bouncybutton {
            menubar.disAppear()
            QMe.save(value: false, key: logedinkey)
            QMe.save(value: "Login As Clerk", key: loginAstitle)
            self.present(storyboardView(boardName: "main", pageID: "loginVC"), animated: false)
        }
    }
    @objc func logoutBUTTON(_ btn:UIButton){
        btn.bouncybutton {
            menubar.disAppear()
            QMe.save(value: false, key: logedinkey)
            self.present(storyboardView(boardName: "main", pageID: "loginVC"), animated: false)
        }
    }
    
    
    
}
