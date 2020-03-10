//
//  addqueueNib.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/10/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit
import DropDown

class addqueueNib: UIView {
    
    
    @IBOutlet weak var bodyview: UIView!
    
    @IBOutlet weak var queueName: UITextField!
    @IBOutlet weak var fromtime: UITextField!
    @IBOutlet weak var totime: UITextField!
    @IBOutlet weak var noOfpersons: UITextField!
    
    @IBOutlet weak var startdayview: UIView!
    @IBOutlet weak var enddayview: UIView!
    let startday = UI()
    let endingday = UI()

    
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
                self.clerklist.ComboBox(clerkNamelist, 0, x: self.clerktitle.frame.maxX+5, y: self.noOfpersons.frame.maxY+10, width: 150, height: 40, bkcolor: #colorLiteral(red: 0.764578104, green: 0.7886356711, blue: 0.8088886142, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cornerRadius: 5, editable: false, placeholder: "Choose Clerk", fontsize: 12, iconColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), listbkcolor: #colorLiteral(red: 0.8419805169, green: 0.8588094115, blue: 0.8688878417, alpha: 1), listTextcolor: #colorLiteral(red: 0.2165208161, green: 0.2892589867, blue: 0.3608489335, alpha: 1), view: self.bodyview) {}
                self.dropdown()
            }
            
        }
        
        self.savebtn.addTarget(self, action: #selector(savebtn(_:)), for: .touchUpInside)
        
    }

    
    func dropdown() {
        startday.ComboBox(["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"], 0, x: 20+60.5+5, y: 165, width: (x-149.5)/2, height: 34, bkcolor: #colorLiteral(red: 0.764578104, green: 0.7886356711, blue: 0.8088886142, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cornerRadius: 5, editable: false, placeholder: "Start Day", fontsize: 12, iconColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), listbkcolor:  #colorLiteral(red: 0.8419805169, green: 0.8588094115, blue: 0.8688878417, alpha: 1), listTextcolor: #colorLiteral(red: 0.2165208161, green: 0.2892589867, blue: 0.3608489335, alpha: 1), view: self.bodyview){}
        
        startday.comboBox.bringSubviewToFront(clerklist.comboBox)
        endingday.ComboBox(["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"], 4, x: 20+60.5+5+(x-149.5)/2+5+14+5, y: 165, width: (x-149.5)/2, height: 34, bkcolor: #colorLiteral(red: 0.764578104, green: 0.7886356711, blue: 0.8088886142, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cornerRadius: 5, editable: false, placeholder: "Start Day", fontsize: 12, iconColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), listbkcolor:  #colorLiteral(red: 0.8419805169, green: 0.8588094115, blue: 0.8688878417, alpha: 1), listTextcolor: #colorLiteral(red: 0.2165208161, green: 0.2892589867, blue: 0.3608489335, alpha: 1), view: self.bodyview){}
        
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
                                       toTime: self.totime.text!,
                                       fromday: self.startday.comboBox.text_comboBox(),
                                       today: self.endingday.comboBox.text_comboBox()) {self.runafter()}
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
                                       toTime: self.totime.text!,
                                       fromday: self.startday.comboBox.text_comboBox(),
                                       today: self.endingday.comboBox.text_comboBox()) {self.runafter()}
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
