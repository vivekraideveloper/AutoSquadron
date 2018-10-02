//
//  AccountCellVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 02/10/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit

class AccountCellVC: UITableViewCell {
    
    
    @IBOutlet weak var accountImageIcons: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
