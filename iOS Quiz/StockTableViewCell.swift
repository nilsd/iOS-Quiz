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
    
    
    // MARK: Functions for adding data to cell
    
    // Add data from Shareville Stock object
    
    func populateWithSharevilleData(data: SharevilleStock) {
        sharevilleData = data
        
        self.symbolLabel.text = self.sharevilleData.symbol
        self.nameLabel.text = self.sharevilleData.name
        
        self.priceActInd.startAnimating()
    }
}
