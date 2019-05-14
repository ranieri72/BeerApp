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
    
    let beerCellIdentifier = "BeerTableViewCell"
    var beers = [Beer]()
    var selectedStyle: Style!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        requestBeer()
    }
    
    func initViews() {
        let nibSearch = UINib.init(nibName: beerCellIdentifier, bundle: nil)
        tableView.register(nibSearch, forCellReuseIdentifier: beerCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
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
        cell.setupCell(beer)
        return cell
    }
}
