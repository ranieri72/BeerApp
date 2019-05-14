//
//  StyleTableViewCell.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 13/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import UIKit

class StyleTableViewCell: UITableViewCell {
    
    @IBOutlet var lbName: UILabel!
    @IBOutlet var lbShortName: UILabel!
    @IBOutlet var lbCategoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(_ style: Style) {
        lbName.text = style.name
        lbShortName.text = style.shortName
        lbCategoryName.text = style.category?.name
    }
}
