//
//  BeerViewController.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 13/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import UIKit

class BeerViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let viewControllerID = "beerDetailVC"
    let beerCellIdentifier = "BeerTableViewCell"
    var beers = [Beer]()
    var selectedStyle: Style!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        requestBeer()
    }
    
    func initViews() {
        title = selectedStyle.shortName
        
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
    
    func requestBeer() {
        func sucess(response: [Any]) {
            if let beersResponse = response as? [Beer] {
                beers = beersResponse
                tableView.isHidden = false
                tableView.reloadData()
            }
        }
        func fail(msg: String) {
            presentAlertView(msg: msg)
        }
        Requester.shared.get(parameter: selectedStyle, method: .getBeers, pageNumber: 1, view: self, sucess: sucess, fail: fail)
    }
    
    func downloadImage(at indexPath: IndexPath) {
        let beer = beers[indexPath.row]
        func sucess(image: UIImage) {
            beers[indexPath.row].image = image
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        func fail(msg: String) {
            print(msg)
        }
        Requester.shared.downloadImage(beer: beer, sucess: sucess, fail: fail)
    }
}

extension BeerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let beer = beers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: beerCellIdentifier, for: indexPath) as! BeerTableViewCell
        if beer.image == nil {
            downloadImage(at: indexPath)
        }
        cell.setupCell(beer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beer = beers[indexPath.row]
        performSegue(withIdentifier: viewControllerID, sender: beer)
    }
}
