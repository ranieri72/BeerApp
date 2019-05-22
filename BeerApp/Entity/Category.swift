//
//  Category.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 14/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import CoreData

extension Category {
    
    convenience init(json: [String:AnyObject]) {
        self.init()
        id = json["id"] as? Int32 ?? 0
        name = json["name"] as? String ?? ""
    }
}
