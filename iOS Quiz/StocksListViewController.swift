//
//  StocksListViewController.swift
//  iOS Quiz
//
//  Created by Nils Dunsö on 2015-10-20.
//  Copyright © 2015 Dunso. All rights reserved.
//

import UIKit

class StocksListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SharevilleManagerDelegate {
    
    let sharevilleManager = SharevilleManager()
    var shareVilleData = [SharevilleStock]()
    
    
    // MARK: Outlets
    
    @IBOutlet weak var stocksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sharevilleManager.delegate = self
        sharevilleManager.fetchAllData()
    }
    
    
    // MARK: UITableView delegate methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StockTableViewCell") as! StockTableViewCell
        
        cell.populateWithSharevilleData(shareVilleData[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shareVilleData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    // MARK: SharevilleManager delegate methods
    
    func shareville(manager: SharevilleManager, didStartFetchingData error: NSError?) {
        print("Fetching data from Shareville...")
    }
    
    func shareville(manager: SharevilleManager, didFinishFetchingData data: [SharevilleStock], error: NSError?) {
        print("Finished fetching data from Shareville")
        
        self.shareVilleData = data
        self.stocksTableView.reloadData()
    }
}

