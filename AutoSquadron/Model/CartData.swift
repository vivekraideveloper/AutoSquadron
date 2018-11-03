//
//  CartData.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 03/11/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import Foundation
import RealmSwift

class CartData: Object {
    
    @objc dynamic var serviceName: String = ""
    @objc dynamic var workshopName: String = ""
    @objc dynamic var servicePrice: String = ""
    
}
