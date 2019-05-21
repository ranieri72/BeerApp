//
//  BeerTableViewCell.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 13/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import UIKit

class BeerTableViewCell: UITableViewCell {

    @IBOutlet var lbName: UILabel!
    @IBOutlet var imgLabel: UIImageView!
    @IBOutlet var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(_ beer: Beer) {
        lbName.text = beer.name
        categoryName.text = beer.style?.category?.name
        if beer.image == nil {
            imgLabel.image = UIImage(named: "beer_bottle")
        } else {
            imgLabel.image = beer.image as? UIImage
        }
    }
}
