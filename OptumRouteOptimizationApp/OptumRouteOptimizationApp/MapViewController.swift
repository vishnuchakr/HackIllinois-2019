//
//  MapViewController.swift
//  OptumRouteOptimizationApp
//
//  Created by Shannon Ferguson on 2/23/19.
//  Copyright © 2019 HackIllinois2019. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet fileprivate weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 37.36, longitude: -122.0, zoom: 6.0)
        mapView.camera = camera
        showMarker(position: camera.target)
    }
    
    func showMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.title = "Palo Alto"
        marker.snippet = "San Francisco"
        marker.map = mapView
    }
}
extension ViewController: GMSMapViewDelegate{
    
}
