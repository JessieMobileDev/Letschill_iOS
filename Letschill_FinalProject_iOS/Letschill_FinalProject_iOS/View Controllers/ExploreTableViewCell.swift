//
//  ExploreTableViewCell.swift
//  Letschill_FinalProject_iOS
//
//  Created by Prajwal Ramamurthy on 2/3/19.
//  Copyright © 2019 Prajwal Ramamurthy. All rights reserved.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timeDate: UILabel!    
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
