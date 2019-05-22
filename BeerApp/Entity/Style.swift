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
        
        id = json["id"] as? Int32 ?? 0
        name = json["name"] as? String ?? ""
        shortName = json["shortName"] as? String ?? ""
        
        if let jsonData = json["category"] as? [String : AnyObject] {
            category = Category(json: jsonData, context: context)
        }
    }
    
    convenience init(_ style: Style, context: NSManagedObjectContext) {
        self.init(context: context)
        
        id = style.id
        name = style.name
        shortName = style.shortName
        
        if let category = style.category {
            self.category = Category(category, context: context)
        }
    }
}
