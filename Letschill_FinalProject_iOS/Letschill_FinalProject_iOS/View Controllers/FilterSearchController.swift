//
//  FilterSearchController.swift
//  Letschill_FinalProject_iOS
//
//  Created by Prajwal Ramamurthy on 12/7/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import Foundation
import UIKit

class FilterSearchController: UIViewController {

@IBAction func checkBoxTapped(_ sender: UIButton) {
    
    UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
        sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }) { (success) in
        sender.isSelected = !sender.isSelected
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = .identity
        }, completion: nil)
    }
    /*if sender.isSelected {
     sender.isSelected = false
     } else {
     sender.isSelected  = true
     }*/
}

}
