//
//  StocksListViewController.swift
//  iOS Quiz
//
//  Created by Nils Dunsö on 2015-10-20.
//  Copyright © 2015 Dunso. All rights reserved.
//

import UIKit

class StocksListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SharevilleManagerDelegate, QuotesManagerDelegate {
    
    
    // MARK: Properties
    
    let sharevilleManager = SharevilleManager()
    var sharevilleData = [SharevilleStock]()
    
    let quotesManager = QuotesManager()
    
    
    // MARK: UI Elements
    let loadingView = LoadingView()
    
    
    // MARK: Outlets
    
    @IBOutlet weak var stocksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(loadingView)
        self.loadingView.start()
        
        self.sharevilleManager.delegate = self
        self.quotesManager.delegate = self
        sharevilleManager.fetchAllData()
    }
    
    
    // MARK: UITableView delegate methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharevilleData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StockTableViewCell") as! StockTableViewCell
        
        cell.populateWithSharevilleData(sharevilleData[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    // MARK: SharevilleManager delegate methods
    
    func shareville(manager: SharevilleManager, didStartFetchingData error: NSError?) {
        print("Fetching data from Shareville...")
    }
    
    func shareville(manager: SharevilleManager, didFinishFetchingData data: [SharevilleStock], error: NSError?) {
        print("Finished fetching data from Shareville")
        
        self.sharevilleData = data
        
        quotesManager.fetchQuotes(self.sharevilleData)
    }
    
    
    // MARK: QuotesManager delegate methods
    
    func quotes(manager: QuotesManager, didStartFetchingData error: NSError?) {
        print("Fetching data from QuotesManager...")
    }
    
    func quotes(manager: QuotesManager, didFinishFetchingData data: QuotesDict, error: NSError?) {
        print("Finished fetching data from QuotesManager")
        
        for stock in self.sharevilleData {
            if let price = data[stock.symbol] {
                stock.price = price
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            self.loadingView.stop()
            self.stocksTableView.reloadData()
        });
    }
}

