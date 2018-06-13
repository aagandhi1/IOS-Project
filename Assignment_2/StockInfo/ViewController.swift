//
//  ViewController.swift
//  StockInfo
//
//  Created by Parth Patel on 2018-04-18.
//  Copyright © 2018 macuser. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var stock = ""
    var open = ""
    var high = ""
    var low = ""
    var close = ""
    var volume = ""
    var allStocks = NSMutableArray()
    let myDatabase = coreDataController()
    
    @IBOutlet weak var symbolName: UILabel!
    @IBOutlet var itemName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        //symbolName.text = stock
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var test = "";
        let context = appDelegate.persistentContainer.viewContext
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Stock")
        
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "symbol") as! String)
                test = data.value(forKey: "symbol") as! String
                allStocks.add(test)
                
            }
        }catch{
            print("Failed");
        }
        //parseData()
        print("done")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.destination is DetailViewController
       {
        let detailView = segue.destination as! DetailViewController
       
        detailView.open = open;
        detailView.high = high;
        detailView.low = low;
        detailView.close = close;
        detailView.volume = volume;
        }
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
        let i = indexPath.row;
        print(allStocks[i]);
        let url = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=" + "\(allStocks[i])" + "&interval=1min&apikey=TEUK0SW0QEMQ3DZ7";
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        print("entered")
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        print("starting task")
        let task = session.dataTask(with: request) { (data, response, error) in
            if (error != nil){
                print("Error")
            }else{
                do{
                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves ) as! NSDictionary
                    //print(fetchedData)
                    let innerArray = fetchedData.value(forKey: "Time Series (1min)") as! NSDictionary
                    let innerTime = Array(innerArray.allValues)[0]
                    self.open = ((innerTime as AnyObject).value(forKey: "1. open") as! NSString) as String
                     self.high = ((innerTime as AnyObject).value(forKey: "2. high") as! NSString) as String
                     self.low = ((innerTime as AnyObject).value(forKey: "3. low") as! NSString) as String
                     self.close = ((innerTime as AnyObject).value(forKey: "4. close") as! NSString) as String
                     self.volume = ((innerTime as AnyObject).value(forKey: "5. volume") as! NSString) as String
                    
                   
                    print("------")
                    print(self.open)
                    print(self.high)
                    print(self.low)
                    print(self.close)
                    print(self.volume)
                   
                    
                }catch{
                    print("Error 2")
                }
            }
        }
        
        task.resume()
        performSegue(withIdentifier: "toDetail", sender: self)
    
    }
    
    
}


extension ViewController : UITableViewDataSource,UITableViewDelegate{
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return allStocks.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        print(allStocks.count)
        let stock = allStocks[indexPath.row]
        
        cell?.textLabel?.text = stock as? String
       
        
        return cell!
        
        
        
        
    }
    
    
    
}



