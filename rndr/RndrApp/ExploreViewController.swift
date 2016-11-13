//
//  ExploreViewController.swift
//  RndrApp
//
//  Created by William Smith on 11/12/16.
//  Copyright © 2016 William Smith. All rights reserved.
//

import UIKit
import GoogleMaps

class ExploreViewController: UIViewController, CLLocationManagerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // get current location from user
        let locManager = CLLocationManager()
        locManager.delegate = self
        locManager.requestAlwaysAuthorization()
        
        var currentLocation : CLLocation!
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorized) {
            
            currentLocation = locManager.location
        }
        else {
            currentLocation = CLLocation(latitude: -33.86, longitude: 151.20)
        }
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 8.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        // todo: query the database and get the location of posts
        var markerPositions : [CLLocation] = [currentLocation!]
        
        for var position in markerPositions {
            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: position.coordinate.latitude, longitude: position.coordinate.longitude)
            marker.title = "Sydney"
            marker.snippet = "Australia"
            marker.map = mapView
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
