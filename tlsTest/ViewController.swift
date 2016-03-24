//
//  ViewController.swift
//  tlsTest
//
//  Created by Samuel B Heather on 24/03/2016.
//  Copyright © 2016 Freedom Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var proxyHosts = ["3.3.3.3"]
    var lastProxyHostsListVersion = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateProxyHostsList()
    }
    
    func updateProxyHostsList() {
        RestApiManager.sharedInstance.getHosts() {json in
            if (json == nil) {
                print("JSON for Update Proxy Hosts was nil")
                return
            }
            
            if let returnedLastProxyHostsListVersion = json["lastProxyHostsListVersion"].int {
                self.lastProxyHostsListVersion = returnedLastProxyHostsListVersion
            }
            
            if json["hostsList"].arrayObject != nil {
                let listOfHosts:[String] = json["hostsList"].arrayValue.map { $0.string!}
                self.proxyHosts = listOfHosts
                print(listOfHosts)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

