//
//  FavoriteViewController.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 06/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var lbMessage: UILabel!
    
    let viewControllerID = "beerFromFavorite"
    let beerCellIdentifier = "BeerTableViewCell"
    
    var fetchedResultsController: NSFetchedResultsController<Beer>!
    
    fileprivate func setupFetchedResultsController() {
        let fetchRequest: NSFetchRequest<Beer> = Beer.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: DataController.shared.viewContext,
            sectionNameKeyPath: nil,
            cacheName: "beers")
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupFetchedResultsController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultsController = nil
    }
    
    func initViews() {
        let nibSearch = UINib.init(nibName: beerCellIdentifier, bundle: nil)
        tableView.register(nibSearch, forCellReuseIdentifier: beerCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == viewControllerID {
            let view = segue.destination as! BeerDetailViewController
            let beer = sender as! Beer
            view.selectedBeer = beer
        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultsController.fetchedObjects?.count ?? 0
        lbMessage.isHidden = count > 0
        tableView.isHidden = count == 0
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let beer = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: beerCellIdentifier, for: indexPath) as! BeerTableViewCell
        cell.setupCell(beer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beer = fetchedResultsController.object(at: indexPath)
        performSegue(withIdentifier: viewControllerID, sender: beer)
    }
}

extension FavoriteViewController: NSFetchedResultsControllerDelegate {
    
}
