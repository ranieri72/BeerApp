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
        
        category = Category(json: json["category"] as! [String : AnyObject], context: context)
    }
}
