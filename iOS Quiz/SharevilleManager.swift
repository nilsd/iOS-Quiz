//
//  SharevilleManager.swift
//  iOS Quiz
//
//  Created by Nils Dunsö on 2015-10-20.
//  Copyright © 2015 Dunso. All rights reserved.
//

import Foundation

protocol SharevilleManagerDelegate {
    func shareville(manager: SharevilleManager, didStartFetchingData error: NSError?) -> Void
    func shareville(manager: SharevilleManager, didFinishFetchingData data: [SharevilleStock], error: NSError?) -> Void
}

class SharevilleManager {
    
    // MARK: Properties
    
    var delegate: SharevilleManagerDelegate?
    let baseUrl = "https://www.shareville.se/api/v1/marketflow/instruments/"
    var fetchedData: [SharevilleStock]!
    
    let stockIds = [
        "apple-inc",
        "microsoft-corporation",
        "facebook-inc-class-a",
        "yahoo-inc",
        "netflix-inc",
        "disney-walt-co-the",
        "google-inc-class-a",
        "amazoncom-inc"
    ]
    
    
    // MARK: Url request
    
    private func fetchOne(stockIdsIndex: Int) {
        let url = "\(baseUrl)\(self.stockIds[stockIdsIndex])"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard data != nil else {
                print("Error when fetching data: \(error)")
                self.delegate?.shareville(self, didFinishFetchingData: self.fetchedData, error: error)
                return
            }
                        
            let json = JSON(data: data!)
            
            // Check if request was somewhat OK by parsing a non-optional Shareville value like 'id'
            if let _ = json["id"].int {
                let sharevilleStock = SharevilleStock(json: json)
                self.fetchedData.append(sharevilleStock)
            } else {
                print("Error parsing stock:")
                print(json["id"].error)
            }
            
            if (stockIdsIndex < self.stockIds.count - 1) {
                // Continue with next stock in array
                self.fetchOne(stockIdsIndex + 1)
            } else {
                
                // Sort array by symbols alphabetically
                self.fetchedData.sortInPlace() { $0.symbol < $1.symbol }
                
                // Call finish
                self.delegate?.shareville(self, didFinishFetchingData: self.fetchedData, error: nil)
            }
        }
        
        task.resume()
    }
    
    
    // MARK: Public functions
    
    func fetchAllData() {
        self.delegate?.shareville(self, didStartFetchingData: nil)
        
        self.fetchedData = [SharevilleStock]()
        
        // Starts fetching data one by one
        self.fetchOne(0)
    }
}