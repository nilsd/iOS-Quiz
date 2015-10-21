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
    
    var currentStockIdsIndex = 0

    
    // MARK: Url request
    
    private func fetchOne() {
        let url = "\(baseUrl)\(self.stockIds[self.currentStockIdsIndex])"
        Network.makeRequest(url, callback: self.handleNetworkResponse)
    }
    
    func handleNetworkResponse(data: NSData?, response: NSURLResponse?, error: NSError?) {
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
        
        if (self.currentStockIdsIndex < self.stockIds.count - 1) {
            // Continue with next stock in array
            self.currentStockIdsIndex++
            self.fetchOne()
        } else {
            
            // Sort array by symbols alphabetically
            self.fetchedData.sortInPlace() { $0.symbol < $1.symbol }
            
            // Call finish
            self.delegate?.shareville(self, didFinishFetchingData: self.fetchedData, error: nil)
        }
    }
    
    
    // MARK: Public functions
    
    func fetchAllData() {
        self.delegate?.shareville(self, didStartFetchingData: nil)
        
        self.fetchedData = [SharevilleStock]()
        
        // Starts fetching data one by one
        self.currentStockIdsIndex = 0
        self.fetchOne()
    }
}