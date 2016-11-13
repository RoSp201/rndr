//
//  DataManager.swift
//  RndrApp
//
//  Created by William Smith on 11/12/16.
//  Copyright © 2016 William Smith. All rights reserved.
//

import UIKit
import Foundation

class DataManager: NSObject {
    
    func changeMetadataAsync(newMetadata: String) {
        var request = URLRequest(url: URL(string: "https://rndr-cal-hacks.azurewebsites.net/target")!)
        request.httpMethod = "POST"
        
        let para:NSMutableDictionary = NSMutableDictionary()
        para.setValue("d440a2766ab3442297abf6f89807a15d", forKey: "id")
        para.setValue(newMetadata, forKey: "metadata")
        let jsonData = try! JSONSerialization.data(withJSONObject: para)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) as! String
        print(jsonString)
        
        //let postString = "{\"id\":\"d440a2766ab3442297abf6f89807a15d\", \"metadata\":\"" + newMetadata + "\"}"
        //print(postString)
        request.httpBody = jsonData
        
        let headers = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            print("Done!")
            print(data!)
            print(response!)
            }.resume()

    }

    
    func retieveNearbyPosts() {
        // Get current location
        // Right now it's hardcoded.
        let lat = 37.861681
        let lon = -122.258464
        
        let headers = [
            "cache-control": "no-cache"
        ]
        
        let url = URL(string: "https://rndrapp.herokuapp.com/posts/" + String(lat) + "/" + String(lon))
        
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        }
        
        task.resume()
    }
}








