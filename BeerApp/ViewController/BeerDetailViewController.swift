//
//  BeerDetailViewController.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 16/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {

    @IBOutlet var imgLabel: UIImageView!
    
    @IBOutlet var lbDesc: UILabel!
    @IBOutlet var lbIBU: UILabel!
    @IBOutlet var lbABV: UILabel!
    @IBOutlet var lbYear: UILabel!
    @IBOutlet var lbGlassName: UILabel!
    
    var selectedBeer: Beer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    func initViews() {
        title = selectedBeer.name
        
        lbDesc.text = selectedBeer.description
        lbIBU.text = selectedBeer.ibu
        lbABV.text = selectedBeer.abv
        lbYear.text = String(selectedBeer.year ?? 0)
        lbGlassName.text = selectedBeer.glass?.name
        if selectedBeer.image == nil {
            imgLabel.image = UIImage(named: "beer_bottle")
        } else {
            imgLabel.image = selectedBeer.image
        }
    }
}
