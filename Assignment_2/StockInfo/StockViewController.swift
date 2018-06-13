//
//  StockDetailViewController.swift
//  StockInfo
//
//  Created by Parth Patel on 2018-04-18.
//  Copyright © 2018 macuser. All rights reserved.
//

import UIKit


class StockViewController : UIViewController {
    
    var allStocks = NSMutableArray()
    let myDatabase = coreDataController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        allStocks = myDatabase.fetchAllStock()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StockViewController : UITableViewDataSource,UITableViewDelegate{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return allStocks.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        let Stock = allStocks[indexPath.row] as! Stock
        
        cell?.textLabel?.text = Stock.symbol
       
        
        return cell!
        
        
        
        
    }
    
    
    
}
