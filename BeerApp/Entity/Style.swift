//
//  Style.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 06/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import CoreData

extension Style {
    
    convenience init(json: [String:AnyObject], context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.id = json["id"] as? Int32 ?? 0
        self.name = json["name"] as? String ?? ""
        self.shortName = json["shortName"] as? String ?? ""
        
        self.category = json["category"] as? Category ?? Category()
    }
}
