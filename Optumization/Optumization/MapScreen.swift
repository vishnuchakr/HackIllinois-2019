//
//  DailyMapViewController.swift
//  Optumization
//
//  Created by Fiza Goyal on 2/23/19.
//  Copyright © 2019 HackIllinois. All rights reserved.
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
    
    var employeeId = 0
    var sourceLocation = CLLocationCoordinate2D(latitude:40.1138 , longitude: -88.2249)
    
//            let destinationLocation = CLLocationCoordinate2D(latitude:40.1059 , longitude: -88.2273)
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


        
        //set delegate for mapview
        self.mapView.delegate = self
        
        getAddresses(id: employeeId)
        
        
    }
    
    func createPathBetweenTwoPoints(sourceLocation: CLLocationCoordinate2D, destinationLocation: CLLocationCoordinate2D, sourceLocationName: String, destinationLocationName: String) {
        
        
        let sourcePin = customPin(pinTitle: sourceLocationName, pinSubTitle: sourceLocationName, location: sourceLocation)
        let destinationPin = customPin(pinTitle: destinationLocationName, pinSubTitle: destinationLocationName, location: destinationLocation)
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
    
    public func getAddresses(id:Int) -> [[String : String]] {
        let temp = ["hi": "hi"]
        guard let url = URL(string: Constants.url + "/getMapData/\(id)" ) else { return [temp] }
        //        let url =
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            print(error)
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                //                print(json)
                guard let jsonResponse = json as? [[String: String]] else{
                    print("unexpected form of json data")
                    return
                }
                
                json
                var sourceLocationName = "Current Location"
                for song in jsonResponse {
                    
                    var retLocation:CLLocationCoordinate2D!
                    
                    let geoCoder = CLGeocoder()
                    geoCoder.geocodeAddressString(song.values.first!) { (placemarks, error) in
                        guard
                            let placemarks = placemarks,
                            let location = placemarks.first?.location
                            else {
                                // handle no location found
                                return
                        }
                        retLocation = location.coordinate
                        
                        print(song.keys.first!)
                        print(song.values.first!)
                        print(retLocation!)
                        print()
                        //CALLMAPPING FUNCTION HERE
                        
                        
                        
                        self.createPathBetweenTwoPoints(sourceLocation: self.sourceLocation, destinationLocation: retLocation, sourceLocationName: ("\(sourceLocationName)"), destinationLocationName: "\(song.keys.first!)")
//                        count = count + 1
                        self.sourceLocation = retLocation
                        sourceLocationName = song.keys.first!
                        
                        // Use your location
                    }
                    
                }
            } catch {
                
            }
            }.resume()
        
        
        return [temp]
    }
    
    //MARK:- MapKit delegates
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red:1.00, green:0.38, blue:0.00, alpha:1.0)
        renderer.lineWidth = 4.0
        return renderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
