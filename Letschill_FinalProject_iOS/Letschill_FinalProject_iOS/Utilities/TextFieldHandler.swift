//
//  UIHandler.swift
//  Letschill_FinalProject_iOS
//
//  Created by Jessica on 12/23/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit

@IBDesignable
class TextFieldHandler: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        if let image = leftImage {
            
            // Image is not nil
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: -3, width: 24, height: 24))
            imageView.image = image
            
            var width = leftPadding + 20
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                
                width = width + 5
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            
            leftView = view
            
        } else {
            
            // Image is nil
            leftViewMode = .never
        }
    }
}
