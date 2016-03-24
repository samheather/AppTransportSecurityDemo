//
//  RestApiManager.swift
//  submarine
//
//  Created by Samuel B Heather on 29/02/2016.
//  Copyright © 2016 Samuel Brendon Heather. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

typealias ServiceResponse = (JSON, NSError?) -> Void

let baseURL = "https://demo.heather.sh:443"

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    func getHosts(
        onCompletion: (JSON) -> Void) {
            
            let requestParams:[String: AnyObject] = [:]
            
            let route = baseURL + "/getHosts"
            
            makeHTTPGetRequest(route, params: requestParams, onCompletion: { json, err in
                onCompletion(json as JSON)
            })
    }
    
    func makeHTTPGetRequest(path: String, params : Dictionary<String, AnyObject>, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        request.HTTPMethod = "POST"
        
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(rawValue:0))
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data!) // TODO - what happens here if the server is offline / DNS doesn't resolve?
            //print("Response: \(json)")
            onCompletion(json, error)
        })
        task.resume()
    }
}