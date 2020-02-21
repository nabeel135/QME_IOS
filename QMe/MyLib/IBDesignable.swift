//
//  IBDesignable.swift
//  Conektr
//
//  Created by Mr. Nabeel on 1/13/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit

@IBDesignable class sbButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet{
            self.layer.masksToBounds = true
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var border: CGFloat = 0.0 {
        didSet{
            self.layer.masksToBounds = true
            self.layer.borderWidth = border
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet{
            self.layer.masksToBounds = true
            self.layer.borderColor = borderColor.cgColor
        }
    }
}

@IBDesignable class sbView: UIView{

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet{

            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet{

            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
}


@IBDesignable class sbImageView: UIImageView{
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet{
            self.layer.masksToBounds = true
            self.layer.cornerRadius = cornerRadius
        }
    }
}


@IBDesignable class sbTextField: UITextField{
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = .clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
