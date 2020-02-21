//
//  editprofileVC.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/6/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class editprofileVC: UIViewController {
    
    
    
    // MARK:- IBOutlets
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var phoneno: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    
    
    
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilepic.loadimage(url: URL(string: getString(key: userImagkey))!)
        firstname.text = getString(key: userNamekey)
        phoneno.text = getString(key: userPhonekey)
        email.text = getString(key: userEmailkey)
        email.isEnabled = false
        
    }
    
    
    
    
    
    
    // MARK:- Buttons
    @IBAction func imagepicker(_ sender: UIButton) {
        sender.bouncybutton {
            let imagepicker = UI()
            imagepicker.ImagePicker(any: self, imagview: self.profilepic, contentMode: .scaleAspectFill)
        }
    }
    
    @IBAction func updateBtn(_ sender: UIButton) {
        sender.bouncybutton {
            if self.validation() {
                self.editprofileAPI()
            }
        }
    }
    
    func validation()-> Bool {
        if firstname.text!.isEmpty || phoneno.text!.isEmpty || email.text!.isEmpty || password.text!.isEmpty || confirmpassword.text!.isEmpty {
            self.showAlert(Title: "Error", Message: "Textfield Should not be Empty!")
            return false
        }
        else{
            if password.text != confirmpassword.text {
                self.showAlert(Title: "Error", Message: "password not matched!")
                return false
            }
            else{return true}
        }
    }
    
    // MARK:- Edit API
    func editprofileAPI(){
        startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"edit_profile",
                                       "apikey":"mtechapi12345",
                                       "user_id":getString(key: userIDkey),
                                       "user_group":getString(key: accTypekey),
                                       "name":firstname.text!,
                                       "phone":phoneno.text!,
                                       "email":email.text!,
                                       "password":password.text!,
                                       "photo":profilepic.toBase64()],
                          headers: ["":""]).responseData
            { response in
                switch(response.result){
                case .success(let data):
                    let d = JSON(data)
                    /*------------------------*/
                    if d["success"].stringValue == "1" {
                        save(value: self.firstname.text!, key: userNamekey)
                        save(value: self.phoneno.text!, key: userPhonekey)
                        save(value: "http://172.104.217.178/qme/files/"+d["image"].stringValue, key: userImagkey)
                        self.dismiss(animated: true)
                    }
                    else{
                        self.showAlert(Title: "Error", Message: d["message"].stringValue)
                    }
                    self.stopLoader()
                    /*------------------------*/
                case .failure(let err):
                    self.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    
}
