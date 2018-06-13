//
//  DetailViewController.swift
//  StockInfo
//
//  Created by Swapnil Shah on 2018-04-22.
//  Copyright © 2018 macuser. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var openValue: UILabel!
    
    @IBOutlet weak var openHigh: UILabel!
    
    @IBOutlet weak var openLow: UILabel!
    
    @IBOutlet weak var openClose: UILabel!
    
    @IBOutlet weak var openVolume: UILabel!
    
    var open = String()
    var high = String()
    var low = String()
    var close = String()
    var volume = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openValue.text = "Open Value is: \(open)"
        openHigh.text = "High Value is: \(high)"
        openLow.text = "Low Value is: \(low)"
        openClose.text = "Close Value is: \(close)"
        openVolume.text = "Volume Value is: \(volume)"
        
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
