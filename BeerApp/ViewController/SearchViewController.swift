//
//  SearchViewController.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 06/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var lbMessage: UILabel!
    
    let viewControllerID = "beerFromSearch"
    let beerCellIdentifier = "BeerTableViewCell"
    
    var beers = [Beer]()
    var beerSearched: String = ""
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    func initViews() {
        searchBar.delegate = self
        searchBar.placeholder = "Digite para buscar cervejas..."
        
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
    
    func restartTimer(){
        timer.invalidate();
        timer = Timer.scheduledTimer(timeInterval: 0.5,
                                     target: self,
                                     selector: #selector(self.requestBeer),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc func requestBeer() {
        func sucess(response: [Any]) {
            if let beersResponse = response as? [Beer] {
                beers = beersResponse
                lbMessage.isHidden = true
                tableView.isHidden = false
                tableView.reloadData()
            }
        }
        func fail(msg: String) {
            lbMessage.text = msg
            lbMessage.isHidden = false
        }
        if !Requester.isRequesting {
            Requester.shared.get(parameter: beerSearched, method: .search, pageNumber: 1, view: self, sucess: sucess, fail: fail)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            beerSearched = searchText
            restartTimer()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beer = beers[indexPath.row]
        performSegue(withIdentifier: viewControllerID, sender: beer)
    }
}
