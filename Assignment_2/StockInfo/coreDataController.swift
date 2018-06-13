//
//  coreDataController.swift
//  StockInfo
//
//  Created by Parth Patel on 2018-04-18.
//  Copyright © 2018 macuser. All rights reserved.
//

import UIKit
import CoreData
import Foundation


class coreDataController {
    
    let allStocks = NSMutableArray()

    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "StockInfo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
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
    
    func insertNewStock(symbol : String)  {
        let stock = NSEntityDescription.insertNewObject(forEntityName: "Stock", into: persistentContainer.viewContext) as! Stock
        
        stock.symbol = "test"
        
        saveContext()
        
        
    }
    
    func fetchAllStock() -> NSMutableArray {
        let fetchStock : NSFetchRequest<Stock> = Stock.fetchRequest()
        
        do{
            let stocks = try persistentContainer.viewContext.fetch(fetchStock)
            
            for stock in stocks {
                allStocks.add(stock)
            }
            
            
        }
        catch{}
        
        return allStocks
        
    }
}
