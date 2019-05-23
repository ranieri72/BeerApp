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
    let refreshControl = UIRefreshControl()
    var styles = [Style]()
    var lastPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        requestStyles(showLoading: true)
    }
    
    func initViews() {
        let nibSearch = UINib.init(nibName: styleCellIdentifier, bundle: nil)
        tableView.register(nibSearch, forCellReuseIdentifier: styleCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Puxe para buscar...")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(sender:AnyObject) {
        styles = [Style]()
        lastPage = 1
        tableView.reloadData()
        requestStyles(showLoading: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == viewControllerID {
            let view = segue.destination as! BeerViewController
            let style = sender as! Style
            view.selectedStyle = style
        }
    }
    
    func updateTable(data: [Style]) {
        var rows = [IndexPath]()
        let startIndex = styles.count
        let lastIndex = startIndex + (data.count - 1)
        for index in startIndex ... lastIndex {
            let indexPath = IndexPath(row: index, section: 0)
            rows.append(indexPath)
        }
        styles.append(contentsOf: data)
        tableView.beginUpdates()
        tableView.insertRows(at: rows, with: .left)
        tableView.endUpdates()
    }
    
    func requestStyles(showLoading: Bool) {
        func sucess(response: [Any]) {
            refreshControl.endRefreshing()
            if let stylesResponse = response as? [Style] {
                tableView.isHidden = false
                updateTable(data: stylesResponse)
                lastPage += 1
            }
        }
        func fail(msg: String) {
            refreshControl.endRefreshing()
            presentAlertView(msg: msg)
        }
        if !Requester.isRequesting {
            Requester.shared.get(parameter: nil, method: .getStyle, pageNumber: lastPage, showLoading: showLoading, view: self, sucess: sucess, fail: fail)
        } else {
            refreshControl.endRefreshing()
        }
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return styles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let style = styles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: styleCellIdentifier, for: indexPath) as! StyleTableViewCell
        cell.setupCell(style)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > styles.count - 10 {
            requestStyles(showLoading: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let style = styles[indexPath.row]
        performSegue(withIdentifier: viewControllerID, sender: style)
    }
}
