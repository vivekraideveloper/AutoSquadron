//
//  HomeWorkshpCell.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 28/10/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit

class HomeWorkshpCell: UITableViewCell {
    
    @IBOutlet weak var workshopImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var shortDesc: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
}
