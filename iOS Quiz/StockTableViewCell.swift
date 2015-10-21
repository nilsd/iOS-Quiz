//
//  StockTableViewCell.swift
//  iOS Quiz
//
//  Created by Nils Dunsö on 2015-10-20.
//  Copyright © 2015 Dunso. All rights reserved.
//

import UIKit

class StockTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var priceActInd: UIActivityIndicatorView!
    
    
    // MARK: Properties
    
    var sharevilleData: SharevilleStock!
    

    // MARK: Function for adding data to cell
    
    func populateWithSharevilleData(data: SharevilleStock) {
        sharevilleData = data
                
        self.symbolLabel.text = self.sharevilleData.symbol
        self.nameLabel.text = self.sharevilleData.name
        
        if (data.price == nil) {
            self.yieldLabel.text = "No data"
        } else {
            self.priceLabel.text = "\(data.price.currentPrice) \(data.price.currency)"
            self.yieldLabel.text = data.price.change
        }
    }
}
