//
//  addqueueNib.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/10/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

class addqueueNib: UIView {
    
    
    @IBOutlet weak var bodyview: UIView!
    
    @IBOutlet weak var queueName: UITextField!
    @IBOutlet weak var fromtime: UITextField!
    @IBOutlet weak var totime: UITextField!
    @IBOutlet weak var noOfpersons: UITextField!
    @IBOutlet weak var savebtn: UIButton!
    @IBOutlet weak var clerktitle: UILabel!
    let clerklist = UI()
    
    
    var parent = UIViewController()
    var runafter:()->Void = {}
    
    func Input(any:Any, runAfter:@escaping()->Void){
        self.parent = any as! UIViewController
        self.runafter = runAfter
        apIobj.clerListAPI(any: any as! UIViewController) {
            if getString(key: accTypekey) == "Clerk" {
                self.clerktitle.isHidden = true
            }
            else{
                self.clerktitle.isHidden = false
                self.clerklist.ComboBox(clerkNamelist, 0, x: self.clerktitle.frame.maxX+5, y: self.noOfpersons.frame.maxY+10, width: 150, height: 40, bkcolor: #colorLiteral(red: 0.2165208161, green: 0.2892589867, blue: 0.3608489335, alpha: 0.3), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cornerRadius: 5, editable: false, placeholder: "Choose Clerk", fontsize: 12, iconColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), listbkcolor: #colorLiteral(red: 0.2165208161, green: 0.2892589867, blue: 0.3608489335, alpha: 0.2), listTextcolor: #colorLiteral(red: 0.2165208161, green: 0.2892589867, blue: 0.3608489335, alpha: 1), view: self.bodyview) {}
            }
            
        }
        
        self.savebtn.addTarget(self, action: #selector(savebtn(_:)), for: .touchUpInside)
        
    }

    
    @objc func savebtn(_ btn:UIButton){
        btn.bouncybutton {
            let obj = adminShopListobj[Selectedshopindex]
            if getString(key: accTypekey) == "Clerk" {
                if self.validation() {
                    apIobj.AddQueueAPI(any: self.parent,
                                       adminId: obj.admin_id,
                                       shopId: obj.shopid,
                                       shopCode: obj.shop_code,
                                       queueName: self.queueName.text!,
                                       noOfpersons: self.noOfpersons.text!,
                                       clerkId: getString(key: userIDkey),
                                       status: "Active",
                                       fromTime: self.fromtime.text!,
                                       toTime: self.totime.text!) {self.runafter()}
                }
            }
            else{
                if self.validation() {
                    let clerk = clerkListobj.filter{$0.name == self.clerklist.comboBox.text_comboBox()}.first!
                    apIobj.AddQueueAPI(any: self.parent,
                                       adminId: getString(key: userIDkey),
                                       shopId: obj.shopid,
                                       shopCode: obj.shop_code,
                                       queueName: self.queueName.text!,
                                       noOfpersons: self.noOfpersons.text!,
                                       clerkId: clerk.clerkId,
                                       status: "Active",
                                       fromTime: self.fromtime.text!,
                                       toTime: self.totime.text!) {self.runafter()}
                }
            }
        }
        
    }
    
    
    func validation() -> Bool{
        if queueName.text!.isEmpty || fromtime.text!.isEmpty || totime.text!.isEmpty || noOfpersons.text!.isEmpty {
            parent.showAlert(Title: "Error", Message: "Textfield should not be empty!")
            return false
        }else{
            return true
        }
    }
    
    @IBAction func cross(_ sender: UIButton) {
        sender.bouncybutton {
            popup.disAppear()
        }
    }
    
}
