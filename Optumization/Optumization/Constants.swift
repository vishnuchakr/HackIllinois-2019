//
//  Constants.swift
//  Optumization
//
//  Created by Himanshu Minocha on 2/23/19.
//  Copyright © 2019 HackIllinois. All rights reserved.
//

import Foundation
import CoreLocation

public class Constants {
    public static var url = "http://10.193.74.106:3000"
    
    
    public static func convertToCoordinates(address:String) {
        var retLocation:CLLocationCoordinate2D!
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    return
            }
            retLocation = location.coordinate
            
        
            // Use your location
        }
    }
    
    
    public static func getAddresses(id:Int) -> [[String : String]] {
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
                        
                        
                        // Use your location
                    }
                    
                }
            } catch {
                
            }
        }.resume()
        
    
        return [temp]
    }
}
