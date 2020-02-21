//
//  accountypeVC.swift
//  QMe
//
//  Created by Mr. Nabeel on 2/8/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

class accountypeVC: UIViewController {
    @IBOutlet var logo: UIView!
    @IBOutlet var buttonview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.frame = CGRect(x: (x/2)-50, y: (y/2)-50, width: 100, height: 100)
        view.addSubview(logo)
        buttonview.frame = CGRect(x: 0, y: (y/2)-80, width: x, height: 170)
        buttonview.isHidden = true
        view.addSubview(buttonview)
        
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6, options: [], animations: {
            self.logo.frame = CGRect(x: (x/2)-50, y: (((y/2)-75)/2)-50, width: 100, height: 100)
        }) { _ in
            self.buttonview.isHidden = false
            coreAnimation.Scale(start: 1, end: 1.2, duration: 0.2, repeatCount: 1, autoReverse: true, view: self.buttonview)
            
        }
        
    }
   
    
    @IBAction func btn(_ sender: UIButton) {
        sender.bouncybutton {
            if "Login As User" == sender.currentTitle! {
                save(value: true, key: isUser)
            }
            save(value: sender.currentTitle!, key: loginAstitle)
            self.present(storyboardView(boardName: "main", pageID: "loginVC"), animated: false)
        }
    }
    
    


}
