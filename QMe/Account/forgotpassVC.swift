//
//  forgotpassVC.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/5/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class forgotpassVC:UIViewController {
    
    
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var sv: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var cv: UIView!
    
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.image = #imageLiteral(resourceName: "logo")
        
        
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.heightAnchor.constraint(equalToConstant: y-100).isActive = true
        
        cv.frame.size.width = x-20
        cv.innerShadow(onSide: .all, shadowColor: #colorLiteral(red: 0.2165208161, green: 0.2892589867, blue: 0.3608489335, alpha: 0.1), shadowSize: 5)
        
    }
    
    
    // MARK:- Buttons
    @IBAction func backbtn(_ sender: UIButton) {
        sender.bouncybutton {
            self.dismiss(animated: false)
        }
    }
    
    @IBAction func forgotBTN(_ sender: UIButton) {
        sender.bouncybutton {
            if self.email.text!.isEmpty {
                self.showAlert(Title: "Error", Message: "Textfield Should not be Empty!")}
            else{self.forgotAPI()}
        }
    }
    
    
    func forgotAPI(){
        Alamofire.request("http://172.104.217.178/qme/api/",
                          method: .post,
                          parameters: ["do":"forget-password",
                                       "apikey":"mtechapi12345",
                                       "email":email.text!],
                          headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseData
            { response in
                switch response.result{
                case .success(let data):
                    let d = JSON(data)
                    self.showAlert(Title: "Error", Message: d["message"].stringValue)
                    
                case .failure(let err):
                    self.showAlert(Title: "Error", Message: err.localizedDescription)
                }
        }
    }
    
    
}
