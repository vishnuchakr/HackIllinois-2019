//////
//////  DailyMapViewController.swift
//////  Optumization
//////
//////  Created by Fiza Goyal on 2/23/19.
//////  Copyright © 2019 HackIllinois. All rights reserved.
//////
////
//
//import UIKit
//import MapKit
//import CoreLocation
//
//class MapScreen: UIViewController, CLLocationManagerDelegate {
//
//    @IBOutlet weak var mapView: MKMapView!
//
//    let locationManager = CLLocationManager()
//    let regionInMeters: Double = 10000
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        checkLocationServices()
//
//
//    }
//
//    func addMarkers(coordinate: CLLocationCoordinate2D, personName: String, address: String) {
//        let annotation = MKPointAnnotation()
//        annotation.title = personName
//        annotation.subtitle = address
//        annotation.coordinate = coordinate
//        mapView.addAnnotation(annotation)
//    }
//
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard annotation is MKPointAnnotation else { return nil }
//
//        let identifier = "Annotation"
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//
//        if annotationView == nil {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            annotationView!.canShowCallout = true
//        } else {
//            annotationView!.annotation = annotation
//        }
//
//        return annotationView
//    }
//
//    func setupLocationManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//
//
//    func centerViewOnUserLocation() {
//        if let location = locationManager.location?.coordinate {
//            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//            mapView.setRegion(region, animated: true)
//        }
//    }
//
//
//    func checkLocationServices() {
//        if CLLocationManager.locationServicesEnabled() {
//            setupLocationManager()
//            checkLocationAuthorization()
//        } else {
//            // Show alert letting the user know they have to turn this on.
//        }
//    }
//
//
//    func checkLocationAuthorization() {
//        switch CLLocationManager.authorizationStatus() {
//        case .authorizedWhenInUse:
//            mapView.showsUserLocation = true
//            centerViewOnUserLocation()
//            locationManager.startUpdatingLocation()
//            break
//        case .denied:
//            // Show alert instructing them how to turn on permissions
//            break
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            // Show an alert letting them know what's up
//            break
//        case .authorizedAlways:
//            break
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//        mapView.setRegion(region, animated: true)
//    }
//
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        checkLocationAuthorization()
//    }
//
//}
//
//

//
//  ViewController.swift
//  DrawRouteOnMapKit
//
//  Created by Aman Aggarwal on 08/03/18.
//  Copyright © 2018 iostutorialjunction. All rights reserved.
//
import UIKit
import MapKit

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}

class MapScreen: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let sourceLocation = CLLocationCoordinate2D(latitude:40.1138 , longitude: -88.2249)
        let destinationLocation = CLLocationCoordinate2D(latitude:40.1059 , longitude: -88.2273)
        let location2 = CLLocationCoordinate2D(latitude:40.1092 , longitude: -88.2272)
        createPathBetweenTwoPoints(sourceLocation: sourceLocation, destinationLocation: destinationLocation, sourceLocationName: "", destinationLocationName: "")
        createPathBetweenTwoPoints(sourceLocation: destinationLocation, destinationLocation: location2, sourceLocationName: "", destinationLocationName: "")
        
        //set delegate for mapview
        self.mapView.delegate = self
        
        
    }
    
    func createPathBetweenTwoPoints(sourceLocation: CLLocationCoordinate2D, destinationLocation: CLLocationCoordinate2D, sourceLocationName: String, destinationLocationName: String) {
        
        
        let sourcePin = customPin(pinTitle: sourceLocationName, pinSubTitle: "", location: sourceLocation)
        let destinationPin = customPin(pinTitle: destinationLocationName, pinSubTitle: "", location: destinationLocation)
        self.mapView.addAnnotation(sourcePin)
        self.mapView.addAnnotation(destinationPin)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResonse = response else {
                if let error = error {
                    print("we have error getting directions==\(error.localizedDescription)")
                }
                return
            }
            
            let route = directionResonse.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    //MARK:- MapKit delegates
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
