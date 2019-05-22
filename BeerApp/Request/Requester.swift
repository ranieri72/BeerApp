//
//  Requester.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 06/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import UIKit
import CoreData

class Requester {
    static let shared = Requester()
    static var isRequesting = false
    
    private var activityIndicator = UIActivityIndicatorView()
    private var strLabel = UILabel()
    private let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private var childContext: NSManagedObjectContext!
    
    init() {
        childContext = DataController.shared.childContext
    }
    
    func get(parameter: Any?,
             method: Constants.apiMethod,
             pageNumber: Int,
             view: UIViewController,
             sucess: @escaping (_ response: [Any]) -> Void,
             fail: @escaping (_ msg: String) -> Void) {
        
        let url = getUrl(parameter, method: method, pageNumber: pageNumber)
        let request = URLRequest(url: URL(string: url)!)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error == nil {
                    
                    switch method {
                    case .getBeers:
                        if let responseData = self.parseBeer(data) {
                            sucess(responseData)
                        } else {
                            fail("Erro ao buscar as cervejas!")
                        }
                    case .getStyle:
                        if let responseData = self.parseStyle(data) {
                            sucess(responseData)
                        } else {
                            fail("Erro ao recuperar os dados!")
                        }
                    case .search:
                        if let responseData = self.parseBeer(data) {
                            sucess(responseData)
                        } else {
                            fail("Erro ao buscar as cervejas!")
                        }
                    }
                } else {
                    fail(error?.localizedDescription ?? "Erro ao recuperar os dados!")
                }
                self.removeActivityIndicator()
                Requester.isRequesting = false
            }
        }
        task.resume()
        addActivityIndicator(view)
        Requester.isRequesting = true
    }
    
    func downloadImage(beer: Beer,
                       sucess: @escaping (_ image: UIImage) -> Void,
                       fail: @escaping (_ msg: String) -> Void) {
        DispatchQueue.main.async {
            if let url = URL(string: beer.label?.medium ?? "") {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        sucess(image)
                    } else {
                        fail("Imagem inválida!")
                    }
                } else {
                    fail("Falha no download!")
                }
            } else {
                fail("URL inválida!")
            }
        }
    }
    
    private func parseBeer(_ data: Data?) -> [Any]? {
        let dataJson =  try! JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
        if let beersJson = dataJson?["data"] as? [[String:AnyObject]] {
            var beers = [Beer]()
            for json in beersJson {
                let beer = Beer(json: json, context: childContext)
                beers.append(beer)
            }
            return beers
        } else {
            return nil
        }
    }
    
    private func parseStyle(_ data: Data?) -> [Any]? {
        let dataJson =  try! JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
        if let stylesJson = dataJson?["data"] as? [[String:AnyObject]] {
            var styles = [Style]()
            for json in stylesJson {
                let style = Style(json: json, context: childContext)
                styles.append(style)
            }
            return styles
        } else {
            return nil
        }
    }
    
    private func getUrl(_ parameter: Any?, method: Constants.apiMethod, pageNumber: Int) -> String {
        var url = Constants.breweryUrl
        url.append(method.string())
        url.append("?key=\(Constants.apiKey)")
        url.append("&p=\(pageNumber)")
        switch method {
        case .getBeers:
            if let style = parameter as? Style {
                url.append("&styleId=\(style.id)")
            }
            break
        case .search:
            if let beer = parameter as? String {
                url.append("&q=\(beer)")
                url.append("&type=beer")
            }
            break
        default: break
        }
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return urlString!
    }
    
    // MARK: Activity Indicator
    
    private func addActivityIndicator(_ view: UIViewController) {
        
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
    
    private func removeActivityIndicator() {
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
    }
}
