//
//  Constants.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 07/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

class Constants {
    static let breweryUrl = "https://sandbox-api.brewerydb.com/v2/"
    static let apiKey = "fe602d75896e002bfd69b82c9df2295d"
    
    enum apiMethod {
        case getBeers
        case getStyle
        case search
        
        func string() -> String {
            switch self {
            case .getBeers:
                return "beers/"
            case .getStyle:
                return "styles/"
            case .search:
                return "search/"
            }
        }
    }
}
