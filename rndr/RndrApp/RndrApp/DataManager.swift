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
        
        // todo: fix me
        //let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        
    }
    
    func retieveNearbyPosts(post : Post) {
        // todo: implement function to retrieve from db
    }
}
