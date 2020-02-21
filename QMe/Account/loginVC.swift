//
//  loginVC.swift
//  QMe
//
//  Created by Mr. Nabeel on 1/31/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON




class loginVC: UIViewController {

    
    // MARK:- IBOutlets
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var bodyscroll: UIScrollView!
    @IBOutlet weak var sv: UIView!
    @IBOutlet weak var cv: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var loginTitle: UILabel!
    
    @IBOutlet weak var signuplabel: UILabel!
    @IBOutlet weak var signupbutton: UIButton!
    
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTitle.text = getString(key: loginAstitle)
        
        
        
        if getString(key: loginAstitle) == "Login As User" {
            signuplabel.isHidden = false
            signupbutton.isHidden = false
        }else{
            signuplabel.isHidden = true
            signupbutton.isHidden = true
        }
        
        
        logo.image = #imageLiteral(resourceName: "logo")
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.heightAnchor.constraint(equalToConstant: y-100).isActive = true
        
        cv.frame.size.width = x-20
        cv.innerShadow(onSide: .all,shadowColor: #colorLiteral(red: 0.2396498481, green: 0.3217300214, blue: 0.4052255198, alpha: 0.1),shadowSize: 5)

        
    }
    
    
    
    
    // MARK:- Buttons
    @IBAction func signupPage(_ sender: UIButton) {
        sender.bouncybutton {
            self.present(storyboardView(boardName: "main", pageID: "signupVC"), animated: false)
        }
    }
    
    
    @IBAction func resetPassPage(_ sender: UIButton) {
        sender.bouncybutton {
            self.present(storyboardView(boardName: "main", pageID: "forgotpassVC"), animated: false)
        }
    }
    @IBAction func loginButton(_ sender: UIButton) {
        sender.bouncybutton {
            if self.validation() {
                self.loginInAPI(loginas: getString(key: loginAstitle))
            }
        }
    }
    
    func validation() -> Bool{
        if email.text!.isEmpty || password.text!.isEmpty {
            self.showAlert(Title: "Error", Message: "Textfield Should not be Empty!")
            return false
        }else{return true}
    }
    
    
    let staticUser = ["Login As User":"User",
                      "Login As Clerk":"Clerk",
                      "Login As Store Admin":"Store Admin"]
    
    func loginInAPI(loginas:String){
        self.startLoader()
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"login",
                                       "apikey":"mtechapi12345",
                                       "email":email.text!,
                                       "password":password.text!],
                          headers: ["":""]).responseData
            { response in
                switch(response.result){
                case .success(let data):
                    let d = JSON(data)
                    /*-----------------------*/
                    self.stopLoader()
                    print(loginas)
                    print(d["result"]["user_group"][0].stringValue)
                    
                    
                    if d["success"].stringValue == "1" && d["result"]["status"].stringValue == "Active" {
                        
                        
                        if self.staticUser[loginas] == d["result"]["user_group"][0].stringValue {
                            save(value: true, key: logedinkey)
                            save(value: d["result"]["id"].stringValue, key: userIDkey)
                            save(value: d["result"]["name"].stringValue, key: userNamekey)
                            save(value: d["result"]["phone"].stringValue, key: userPhonekey)
                            save(value: d["result"]["email"].stringValue, key: userEmailkey)
                            save(value: "http://172.104.217.178/qme/files/"+d["result"]["photo"].stringValue, key: userImagkey)
                            save(value: d["result"]["user_group"][0].stringValue, key: accTypekey)
                            
                            
                            if d["result"]["user_group"][0].stringValue == "Store Admin" {
                                self.present(storyboardView(boardName: "main", pageID: "adminDashboardVC"), animated: false)
                            }
                            else if d["result"]["user_group"][0].stringValue == "Clerk" {
                                self.present(storyboardView(boardName: "main", pageID: "adminDashboardVC"), animated: false)
                            }
                            else if d["result"]["user_group"][0].stringValue == "User" {
                                self.present(storyboardView(boardName: "main", pageID: "userDashboardVC"), animated: false)
                            }
                        }
                        else{
                            self.showAlert(Title: "Message", Message: "Please login from \(d["result"]["user_group"][0].stringValue)'s login page")
                        }
                        
                    }
                    else{
                        if d["success"].stringValue == "1" {
                            self.showAlert(Title: "Error", Message: "Account is not active!")
                        }else{
                            self.showAlert(Title: "Error", Message: d["message"].stringValue)
                        }
                    }
                    /*-----------------------*/
                case .failure(let err):
                    self.stopLoader()
                    self.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }

}











