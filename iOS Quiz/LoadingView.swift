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
        
        self.actInd.frame = self.frame
        
        self.addSubview(actInd)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func start() {
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
}
