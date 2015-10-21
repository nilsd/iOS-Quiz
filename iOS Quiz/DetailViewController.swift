//
//  DetailViewController.swift
//  iOS Quiz
//
//  Created by Nils Dunsö on 2015-10-21.
//  Copyright © 2015 Dunso. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var infoTextView: UITextView!
    
    
    // MARK: Properties
    
    var sharevilleData: SharevilleStock!
    let companyDescriptions = CompanyDescriptions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = sharevilleData.name
        
        if let companyDescription = companyDescriptions.all[sharevilleData.symbol] {
            self.infoTextView.text = companyDescription
        } else {
            self.infoTextView.text = "No description."
        }
    }
}