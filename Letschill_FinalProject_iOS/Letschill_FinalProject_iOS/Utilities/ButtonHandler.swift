//
//  ButtonHandler.swift
//  Letschill_FinalProject_iOS
//
//  Created by Jessica on 12/23/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit

@IBDesignable
class ButtonHandler: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
