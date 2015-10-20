//
//  QuotesManager.swift
//  iOS Quiz
//
//  Created by Nils Dunsö on 2015-10-20.
//  Copyright © 2015 Dunso. All rights reserved.
//

import Foundation

protocol QuotesManagerDelegate {
    func quotes(manager: QuotesManager, didStartFetchingData error: NSError?) -> Void
    func quotes(manager: QuotesManager, didFinishFetchingData data: QuotesDict, error: NSError?) -> Void
}

class QuotesManager {
    
    // MARK: Properties
    
    var delegate: QuotesManagerDelegate?
    
    let baseUrl = "https://query.yahooapis.com/v1/public/yql?q=" + "select * from yahoo.finance.quote where symbol in ".stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
    let endUrl = "&format=json&env=store://datatables.org/alltableswithkeys".stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
    
    var fetchedQuotes: QuotesDict!
    
    func makeSymbolsString(sharevilleStocks: [SharevilleStock]) -> String? {
        var symbolsArray = [String]()
        
        for stock in sharevilleStocks {
            symbolsArray.append("\"\(stock.symbol)\"")
        }
        
        var string = "("
        string += symbolsArray.joinWithSeparator(",")
        string += ")"
        
        return string
    }
    
    func fetchQuotes(sharevilleStocks: [SharevilleStock]) {
        self.delegate?.quotes(self, didStartFetchingData: nil)
        
        self.fetchedQuotes = QuotesDict()
        
        var symbolsString = self.makeSymbolsString(sharevilleStocks)
        
        if (symbolsString == nil) {
            print("Symbols string error")
            return
        }
        
        symbolsString = symbolsString!.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        
        let url = "\(self.baseUrl)\(symbolsString!)\(self.endUrl)"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard data != nil else {
                print("Error when fetching data: \(error)")
                return
            }
                        
            let json = JSON(data: data!)
            
            if let quotes = json["query"]["results"]["quote"].array {
                for quoteData in quotes {
                    let symbol = quoteData["symbol"].string
                    
                    let currentPrice = quoteData["LastTradePriceOnly"].string
                    let change = quoteData["Change"].string
                    
                    self.fetchedQuotes[symbol!] = Price(currentPrice: currentPrice, change: change)
                }
                
                self.delegate?.quotes(self, didFinishFetchingData: self.fetchedQuotes, error: nil)
            }
        }
        
        task.resume()
    }
}