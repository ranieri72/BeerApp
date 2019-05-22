//
//  DataController.swift
//  BeerApp
//
//  Created by Ranieri Aguiar on 21/05/19.
//  Copyright © 2019 Ranieri. All rights reserved.
//

import CoreData

class DataController {
    static let shared = DataController()
    
    lazy var persistentContainer: NSPersistentContainer = {
        print("persistentContainer foi criado")
        let container = NSPersistentContainer(name: "BeerApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        print("viewContext foi chamado")
        return persistentContainer.viewContext
    }
    
    lazy var childContext: NSManagedObjectContext = {
        print("childContext foi criado")
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = viewContext
        return childContext
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
