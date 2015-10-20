//
//  SharevilleStock.swift
//  iOS Quiz
//
//  Created by Nils Dunsö on 2015-10-20.
//  Copyright © 2015 Dunso. All rights reserved.
//

import Foundation

class SharevilleStock {
    
    // MARK: Properties according to Shareville response JSON
    
    var id: Int!
    var comment_count: Int!
    var org_info: String!
    var stream_count: Int!
    var stream_count_1d: Int!
    var instrument_id: String!
    var name: String!
    var symbol: String!
    var isin_code: String!
    var multiplier: String!
    var instrument_group_type: String!
    var instrument_type: String!
    var occurence_prc: String!
    var sector_group: String!
    var slug: String!
    var sector: String!
    var updated_at: String!
    var status: Int!
    var currency: String!
    var country: String!
    
    // MARK: Property for storing Price
    
    var price: Price!
    
    // MARK: Init
    
    init(json: JSON) {

        self.id = json["id"].int
        self.comment_count = json["comment_count"].int
        self.org_info = json["org_info"].string
        self.stream_count = json["stream_count"].int
        self.stream_count_1d = json["stream_count_1d"].int
        self.instrument_id = json["instrument_id"].string
        self.name = json["name"].string
        self.symbol = json["symbol"].string
        self.isin_code = json["isin_code"].string
        self.multiplier = json["multiplier"].string
        self.instrument_group_type = json["instrument_group_type"].string
        self.instrument_type = json["instrument_type"].string
        self.occurence_prc = json["occurence_prc"].string
        self.sector_group = json["sector_group"].string
        self.slug = json["slug"].string
        self.sector = json["sector"].string
        self.updated_at = json["updated_at"].string
        self.status = json["status"].int
        self.currency = json["currency"].string
        self.country = json["country"].string
    }
}