//
//  signupVC.swift
//  QMe
//
//  Created by Mr. Nabeel on 1/31/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class signupVC: UIViewController {
    
    
    
    //MARK:- IBOutlet
    @IBOutlet weak var profilepic: UIImageView!
    
    
    
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var phoneno: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    
    @IBOutlet var bodyview: UIView!
    @IBOutlet weak var bodyscroll: UIScrollView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyscroll.frame = CGRect(x: 0, y: 0, width: x, height: y)
        view.addSubview(bodyscroll)
        bodyview.frame = CGRect(x: 0, y: 0, width: x, height: 800)
        bodyscroll.addSubview(bodyview)
        bodyscroll.contentSize.height = bodyview.frame.size.height
        
        
    }
    
    
    
    
    
    
    // MARK:- Buttons
    
    @IBAction func uploadpic(_ sender: UIButton) {
        sender.bouncybutton {
            let picker = UI()
            picker.ImagePicker(any: self, imagview: self.profilepic, contentMode: .scaleAspectFill)
        }
    }
    @IBAction func loginInpage(_ sender: UIButton) {
        sender.bouncybutton {
            self.dismiss(animated: false)
        }

    }
    
    @IBAction func signupButton(_ sender: UIButton) {
        sender.bouncybutton {
            if self.validation() {
                self.signupAPI()
            }
        }
    }
    
    func validation() -> Bool{
        if firstname.text!.isEmpty || email.text!.isEmpty || phoneno.text!.isEmpty || password.text!.isEmpty || confirmpassword.text!.isEmpty{
            self.showAlert(Title: "Error", Message: "Textfield should not be empty!")
            return false
        }
        else{
            if password.text == confirmpassword.text {
                return true
            }else{
                self.showAlert(Title: "Error", Message: "passwords doesn't matched!")
                return false
            }
        }
    }
    
    func signupAPI(){
        self.startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"signup",
                                       "apikey":"mtechapi12345",
                                       "name":firstname.text!,
                                       "email":email.text!,
                                       "password":password.text!,
                                       "photo":profilepic.toBase64(),
                                       "phone":phoneno.text!],
                          headers: ["":""]).responseData
            { response in
                switch response.result{
                case .success(let data):
                    let d = JSON(data)
                    /*--------------------*/
                    self.stopLoader()
                    if d["success"].stringValue == "1" {
//                        self.present(storyboardView(boardName: "main", pageID: "loginVC"), animated: false)
                        self.dismiss(animated: false)
                    }
                    else{
                        self.showAlert(Title: "Success", Message: d["message"].stringValue)
                    }
                    
                    /*--------------------*/
                case .failure(let err):
                    self.stopLoader()
                    self.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
        
    }
    
}







