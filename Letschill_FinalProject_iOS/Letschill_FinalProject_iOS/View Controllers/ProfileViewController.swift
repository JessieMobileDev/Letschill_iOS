//
//  ProfileViewController.swift
//  Letschill_FinalProject_iOS
//
//  Created by Prajwal Ramamurthy on 2/3/19.
//  Copyright © 2019 Prajwal Ramamurthy. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController{
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        //profileImage.frame(forAlignmentRect: CGRectMake(0,0,100,100))
        
        profileImage.layer.borderWidth = 1.0
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.white.cgColor
        
    }
}
