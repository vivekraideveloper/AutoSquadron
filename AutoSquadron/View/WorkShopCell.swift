//
//  WorkShopCell.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 03/10/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit

class WorkShopCell: UITableViewCell {

    @IBOutlet weak var workshopImage: UIImageView!
    @IBOutlet weak var workshopName: UILabel!
    @IBOutlet weak var workshopDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
