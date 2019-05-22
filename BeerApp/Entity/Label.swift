//
//  Label.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 19/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import CoreData

extension Label {
    
    convenience init(json: [String:AnyObject]) {
        self.init()
        medium = json["medium"] as? String ?? ""
    }
}
