//
//  Price.swift
//  iOS Quiz
//
//  Created by Nils Dunsö on 2015-10-20.
//  Copyright © 2015 Dunso. All rights reserved.
//

import Foundation

struct Price {
    var currentPrice: String!
    var change: String!
    var currency: String!
    
    init(currentPrice: String?, change: String?, currency: String?) {
        // If values are nil, use empty strings
        
        self.currentPrice = (currentPrice != nil) ? currentPrice : ""
        self.change = (change != nil) ? change : ""
        self.currency = (currency != nil) ? currency : ""
    }
}