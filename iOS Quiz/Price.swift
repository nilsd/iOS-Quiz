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
    
    init(currentPrice: String?, change: String?) {
        self.currentPrice = currentPrice!
        self.change = change!
    }
}