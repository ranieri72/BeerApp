//
//  BeerDetailViewController.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 16/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import UIKit
import CoreData

class BeerDetailViewController: UIViewController {

    @IBOutlet var imgLabel: UIImageView!
    
    @IBOutlet var lbDesc: UILabel!
    @IBOutlet var lbIBU: UILabel!
    @IBOutlet var lbABV: UILabel!
    @IBOutlet var lbYear: UILabel!
    @IBOutlet var lbGlassName: UILabel!
    @IBOutlet var btnStar: UIButton!
    
    var persistentContainer: NSPersistentContainer!
    var selectedBeer: Beer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        persistentContainer = DataController.shared.persistentContainer
    }
    
    func initViews() {
        title = selectedBeer.name
        
        lbDesc.text = selectedBeer.desc
        lbIBU.text = selectedBeer.ibu
        lbABV.text = selectedBeer.abv
        lbYear.text = String(selectedBeer.year)
        lbGlassName.text = selectedBeer.glass?.name
        if selectedBeer.image == nil {
            imgLabel.image = UIImage(named: "beer_bottle")
        } else {
            imgLabel.image = selectedBeer.image as? UIImage
        }
    }
    
    @IBAction func favoring(_ sender: UIButton) {
        do {
            try selectedBeer.managedObjectContext?.save()
//            persistentContainer.viewContext.insert(selectedBeer)
//            try persistentContainer.viewContext.save()
            btnStar.setImage(UIImage(named: "selected_star"), for: .normal)
        } catch {
            presentAlertView(msg: "Erro ao salvar cerveja!")
        }
    }
}
