//
//  LoadingView.swift
//  iOS Quiz
//
//  Created by Nils Dunsö on 2015-10-21.
//  Copyright © 2015 Dunso. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    var actInd = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    var errorLabel: UILabel!
    
    override init(var frame: CGRect) {
        frame.size.width = screenSize.width
        frame.size.height = screenSize.height
        super.init(frame: frame)
        
        // "Hide"
        self.alpha = 0
        
        // Prevent tableview touches when loading view is visible
        self.userInteractionEnabled = true
        
        // A dark background with transparency
        let darkView = UIView(frame: self.frame)
        darkView.backgroundColor = .blackColor()
        darkView.alpha = 0.35
        self.addSubview(darkView)
        
        // Activity indicator
        self.actInd.frame = self.frame
        self.actInd.hidesWhenStopped = true
        self.addSubview(self.actInd)
        
        // Label for error info
        self.errorLabel = UILabel(frame: CGRect(x: 0, y: self.frame.height / 2 + 40, width: self.frame.width, height: 30))
        self.errorLabel.textColor = UIColor.whiteColor()
        self.errorLabel.font = UIFont(name: "Helvetica Neue", size: 18)
        self.errorLabel.textAlignment = .Center
        self.addSubview(self.errorLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func start() {
        // Reset errorLabel text
        self.errorLabel.text = ""
        
        UIView.animateWithDuration(0.1, animations: {
            self.alpha = 1
        })
        
        self.actInd.startAnimating()
    }
    
    func stop() {
        UIView.animateWithDuration(0.1, animations: {
            self.alpha = 0
        })
        
        self.actInd.stopAnimating()
    }
    
    func setErrorText(text: String) {
        self.errorLabel.text = text
    }
}
