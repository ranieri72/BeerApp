//
//  Beer.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 06/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import UIKit

struct Beer: Codable {
    var name: String?
    var description: String?
    var abv: String?
    var ibu: String?
    var year: Int?
    
    var labels: Label?
    var style: Style?
    var glass: Glass?
    
    var image: UIImage?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case description
        case abv
        case ibu
        case year
        case labels
        case style
        case glass
    }
}
