//
//  WorkshopDetailCell.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 07/10/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit

class WorkshopDetailCell: UITableViewCell {

    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   
}
