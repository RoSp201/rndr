//
//  DataManager.swift
//  RndrApp
//
//  Created by William Smith on 11/12/16.
//  Copyright © 2016 William Smith. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    func createPost(post: Post) {
        var jsonString : NSString = ""
        
        // create json files
        var json : [String : AnyObject] = [
            "author" : post.author, "type" : post.type as AnyObject,
            "url" : post.url, "location" : post.location as AnyObject,
            "marker" : post.marker
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            // here "decoded" is of type `Any`, decoded from JSON data
            print(decoded)
            
            // you can now cast it with the right type
            if let dictFromJSON = decoded as? [String:String] {
                // use dictFromJSON
            }
            
            jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)!
            
            // do something with json string here
            
        } catch {
            print(error.localizedDescription)
        }
        
        
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache",
            "postman-token": "4a15bf02-cfb9-de37-bfbd-c373ec34157d"
        ]
        
        var request = NSMutableURLRequest(url: NSURL(string: "https://rndrapp.herokuapp.com/post")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })
        
        dataTask.resume()
    }
    
    func retieveNearbyPosts() {
        // todo: implement function to retrieve from db
        // get current location
        let headers = [
            "cache-control": "no-cache",
            "postman-token": "56af9e0b-e820-e7c5-917b-027cd21ae5f8"
        ]
        
        var request = NSMutableURLRequest(url: URL(string: "https://rndrapp.herokuapp.com/posts/:lat/:lon")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })
        
        dataTask.resume()
    }
}








