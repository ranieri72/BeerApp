//
//  Requester.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 06/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import UIKit

class Requester {
    
    private static var activityIndicator = UIActivityIndicatorView()
    private static var strLabel = UILabel()
    private static let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    static func getStudents(_ view: UIViewController, sucess: @escaping (_ beers: [Beer]) -> Void, fail: @escaping (_ msg: String) -> Void) {
        let url = getUrl(method: .getBeers)
        let request = URLRequest(url: URL(string: url)!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if error == nil {
                    let beerResponse = try! JSONDecoder().decode(BeerResponse.self, from: data!)
                    if let beers = beerResponse.data {
                        sucess(beers)
                    } else {
                        fail("Nenhuma cerveja encontrada!")
                    }
                } else {
                    fail(error?.localizedDescription ?? "Erro ao recuperar os estudantes!")
                }
                removeActivityIndicator()
            }
        }
        task.resume()
        addActivityIndicator(view)
    }
    
    private static func getUrl(method: Constants.apiMethod) -> String {
        var url = Constants.breweryUrl
        url.append(method.string())
        url.append("?key=\(Constants.apiKey)")
        return url
    }
    
    // MARK: Activity Indicator
    
    private static func addActivityIndicator(_ view: UIViewController) {
        
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = "Loading..."
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.view.frame.midX - strLabel.frame.width/2, y: view.view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.view.addSubview(effectView)
    }
    
    private static func removeActivityIndicator() {
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
    }
}
