//
//  MenuViewController.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 06/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let viewControllerID = "beerVC"
    let styleCellIdentifier = "StyleTableViewCell"
    var styles = [Style]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        requestStyles()
    }
    
    func initViews() {
        let nibSearch = UINib.init(nibName: styleCellIdentifier, bundle: nil)
        tableView.register(nibSearch, forCellReuseIdentifier: styleCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == viewControllerID {
            let view = segue.destination as! BeerViewController
            let style = sender as! Style
            view.selectedStyle = style
        }
    }
    
    func requestStyles() {
        func sucess(response: [Any]) {
            tableView.reloadData()
        }
        func fail(msg: String) {
            presentAlertView(msg: msg)
        }
        Requester.shared.get(method: .getStyle, pageNumber: 1, self, sucess: sucess, fail: fail)
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return styles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let style = styles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: styleCellIdentifier, for: indexPath) as! StyleTableViewCell
        cell.setupCell(style)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let style = styles[indexPath.row]
        performSegue(withIdentifier: viewControllerID, sender: style)
    }
}
