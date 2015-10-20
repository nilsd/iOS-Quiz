//
//  StockTableViewCell.swift
//  iOS Quiz
//
//  Created by Nils Dunsö on 2015-10-20.
//  Copyright © 2015 Dunso. All rights reserved.
//

import UIKit

class StockTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    var sharevilleData: SharevilleStock!
    

    // MARK: Outlets
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var priceActInd: UIActivityIndicatorView!
    
    
    // MARK: Function for adding data to cell
    
    func populateWithSharevilleData(data: SharevilleStock) {
        sharevilleData = data
        
        self.symbolLabel.text = self.sharevilleData.symbol
        self.nameLabel.text = self.sharevilleData.name
                
        self.priceLabel.text = data.price.currentPrice + " USD"
        self.yieldLabel.text = data.price.change + "%"
    }
}