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


// Fields for querying Yahoo Finance
enum YahooQuoteProperty: String {
    case Symbol = "s"
    case LastTradePriceOnly = "l1"
    case ChangeInPercent = "p2"
    case Currency = "c4"
    
    static let all = [Symbol, LastTradePriceOnly, ChangeInPercent, Currency]
    
    static func indexValue(prop: YahooQuoteProperty) -> Int? {
        for i in 0...all.count {
            if (prop.rawValue == all[i].rawValue) { return i }
        }
        
        return nil
    }
}

class QuotesManager {
    
    // MARK: Properties
    
    var delegate: QuotesManagerDelegate?
    let baseUrl = "https://download.finance.yahoo.com/d/quotes.csv?f="
    var fetchedQuotes: QuotesDict!
    
    
    // MARK: Url request
    
    func fetchQuotes(sharevilleStocks: [SharevilleStock]) {
        self.delegate?.quotes(self, didStartFetchingData: nil)
        
        // Reset self.fetchedQuotes
        self.fetchedQuotes = QuotesDict()
        
        // Build url
        var url = self.baseUrl
        
        // Set query properties
        for prop in YahooQuoteProperty.all {
            url += prop.rawValue
        }
        
        // Make comma separated list of stock symbols
        let symbolsString = self.makeSymbolsString(sharevilleStocks)

        if (symbolsString == nil) {
            print("Symbols string error")
            return
        }
        
        url += "&s=" + symbolsString!
        
        // Create request
        Network.makeRequest(url, callback: self.handleNetworkResponse)
    }
    
    func handleNetworkResponse(data: NSData?, response: NSURLResponse?, error: NSError?) {
        guard data != nil else {
            print("Error when fetching data: \(error)")
            self.delegate?.quotes(self, didFinishFetchingData: self.fetchedQuotes, error: error)
            return
        }
        
        let dataArray = self.csvDataToArray(data!)
        
        for var obj in dataArray {
            let symbol = obj[YahooQuoteProperty.indexValue(YahooQuoteProperty.Symbol)!].replace("\"", withString: "")
            let currentPrice = obj[YahooQuoteProperty.indexValue(YahooQuoteProperty.LastTradePriceOnly)!].replace("\"", withString: "")
            let change = obj[YahooQuoteProperty.indexValue(YahooQuoteProperty.ChangeInPercent)!].replace("\"", withString: "")
            let currency = obj[YahooQuoteProperty.indexValue(YahooQuoteProperty.Currency)!].replace("\"", withString: "")
            
            self.fetchedQuotes[symbol] = Price(currentPrice: currentPrice, change: change, currency: currency)
        }
        
        self.delegate?.quotes(self, didFinishFetchingData: self.fetchedQuotes, error: nil)
    }
    
    
    // MARK: Utility functions
    
    func makeSymbolsString(sharevilleStocks: [SharevilleStock]) -> String? {
        var symbolsArray = [String]()
        
        for stock in sharevilleStocks {
            symbolsArray.append(stock.symbol)
        }
        
        let string = symbolsArray.joinWithSeparator(",")
        
        return string.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
    }
    
    func csvDataToArray(csv: NSData) -> [Array<String>] {
        let dataString = NSString(data: csv, encoding: NSUTF8StringEncoding) as! String
        var allData = [Array<String>]()
        
        let rows = dataString.characters.split{$0 == "\n"}.map(String.init)
        
        for row in rows {
            let stock = row.characters.split{$0 == ","}.map(String.init)
            allData.append(stock)
        }
        
        return allData
    }
}