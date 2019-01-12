//
//  WorkshopModel.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 03/01/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import Foundation

class WorkshopModel {
    
    var name: String
    var imageUrl: String
    var img1: String
    var img2: String
    var img3: String
    var shortDesc: String
    var services: Dictionary<String, Dictionary<String, Any>>
    
    init(name: String, imageUrl: String, img1: String, img2: String, img3: String, shortDesc: String, services: Dictionary<String, Dictionary<String, Any>>) {
        self.name = name
        self.imageUrl = imageUrl
        self.img1 = img1
        self.img2 = img2
        self.img3 = img3
        self.shortDesc = shortDesc
        self.services = services
    }
}
