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
    
    var fetchedResultsController: NSFetchedResultsController<Beer>!
    var persistentContainer: NSPersistentContainer!
    var viewContext: NSManagedObjectContext!
    
    var selectedBeer: Beer!
    var fetchedBeer: Beer!
    var isFavorite = false
    
    fileprivate func setupFetchedResultsController() {
        let fetchRequest: NSFetchRequest<Beer> = Beer.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let predicate = NSPredicate(format: "id == %@", selectedBeer.id ?? "")
        fetchRequest.predicate = predicate
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: DataController.shared.viewContext,
            sectionNameKeyPath: nil,
            cacheName: "beers")
        do {
            try fetchedResultsController.performFetch()
            fetchBeer()
            changeButton()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        persistentContainer = DataController.shared.persistentContainer
        viewContext = DataController.shared.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupFetchedResultsController()
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
    
    func fetchBeer() {
        if let fetchedBeer = fetchedResultsController.fetchedObjects {
            if fetchedBeer.count > 0 {
                isFavorite = true
                self.fetchedBeer = fetchedBeer[0]
            }
        }
    }
    
    func changeButton() {
        if isFavorite {
            btnStar.setImage(UIImage(named: "selected_star"), for: .normal)
        } else {
            btnStar.setImage(UIImage(named: "unselected_star"), for: .normal)
        }
    }
    
    @IBAction func favoring(_ sender: UIButton) {
        do {
            if isFavorite {
                viewContext.delete(fetchedBeer)
            } else {
                let managedBeer = Beer(selectedBeer, context: viewContext)
                viewContext.insert(managedBeer)
            }
            try viewContext.save()
            isFavorite = !isFavorite
            changeButton()
        } catch {
            presentAlertView(msg: "Erro ao salvar cerveja!")
        }
    }
}
