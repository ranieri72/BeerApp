//
//  Glass.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 19/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import CoreData

extension Glass {
    
    convenience init(json: [String:AnyObject]) {
        self.init()
        id = json["id"] as? Int32 ?? 0
        name = json["name"] as? String ?? ""
    }
}
