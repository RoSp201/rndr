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
            
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) as! String
            jsonString
            
            // do something with json string here
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func retieveNearbyPosts() {
        // todo: implement function to retrieve from db
        // get current location
    }
}
