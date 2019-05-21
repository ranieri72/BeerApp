//
//  Category.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 14/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import CoreData

extension Category {
    
    convenience init(json: [String:AnyObject], context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.id = json["id"] as? Int32 ?? 0
        self.name = json["name"] as? String ?? ""
    }
}
