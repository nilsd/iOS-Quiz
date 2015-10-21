//
//  Network.swift
//  iOS Quiz
//
//  Created by Nils Dunsö on 2015-10-21.
//  Copyright © 2015 Dunso. All rights reserved.
//

import Foundation

class Network {
    static func makeRequest(urlString: String, callback: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            callback(data: data, response: response, error: error)
        }
        
        task.resume()
    }
}