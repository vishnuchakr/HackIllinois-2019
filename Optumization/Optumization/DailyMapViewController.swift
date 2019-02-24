//
//  DailyMapViewController.swift
//  Optumization
//
//  Created by Fiza Goyal on 2/23/19.
//  Copyright © 2019 HackIllinois. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class DailyMapViewController: UIViewController {
    
    @IBOutlet var mapView: GMSMapView!
    var marker = GMSMarker()
    var sourceLat = 23.0225
    var sourceLong = 72.5714
    var rectangle = GMSPolyline()
    //var snackbar: MJSnackBar!
    
    // You don't need to modify the default init(nibName:bundle:) method.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: sourceLat, longitude: sourceLong, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let position = CLLocationCoordinate2DMake(sourceLat, sourceLong)
        self.marker = GMSMarker(position: position)
        let pinColor = UIColor.orange
        self.marker.icon = GMSMarker.markerImage(with: pinColor)
        self.marker.map = self.mapView
        
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        //self.snackbar = MJSnackBar(onView: self.view)
        
        
    }
}
