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
        id = json["id"] as? String ?? ""
        name = json["name"] as? String ?? ""
        desc = json["description"] as? String ?? ""
        abv = json["abv"] as? String ?? ""
        ibu = json["ibu"] as? String ?? ""
        year = json["year"] as? Int32 ?? 0
        
        if let jsonData = json["labels"] as? [String : AnyObject] {
            label = Label(json: jsonData, context: context)
        }
        if let jsonData = json["style"] as? [String : AnyObject] {
            style = Style(json: jsonData, context: context)
        }
        if let jsonData = json["glass"] as? [String : AnyObject] {
            glass = Glass(json: jsonData, context: context)
        }
        image = nil
    }
    
    convenience init(_ beer: Beer, context: NSManagedObjectContext) {
        self.init(context: context)
        id = beer.id
        name = beer.name
        desc = beer.desc
        abv = beer.abv
        ibu = beer.ibu
        year = beer.year
        
        if let label = beer.label {
            self.label = Label(label, context: context)
        }
        if let style = beer.style {
            self.style = Style(style, context: context)
        }
        if let glass = beer.glass {
            self.glass = Glass(glass, context: context)
        }
        image = nil
    }
}
