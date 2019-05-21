//
//  Beer.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 06/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import CoreData

extension Beer {
    
    convenience init(json: [String:AnyObject], context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.name = json["name"] as? String ?? ""
        self.desc = json["description"] as? String ?? ""
        self.abv = json["abv"] as? String ?? ""
        self.ibu = json["ibu"] as? String ?? ""
        self.year = json["year"] as? Int32 ?? 0
        
        self.label = json["labels"] as? Label ?? Label()
        self.style = json["style"] as? Style ?? Style()
        self.glass = json["glass"] as? Glass ?? Glass()
        
        self.image = nil
    }
}
