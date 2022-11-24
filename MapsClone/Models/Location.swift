//
//  Location.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/23/22.
//

import MapKit
import CoreLocation

struct Location{
    
    lazy var latitude: CLLocationDegrees = 51.4934
    lazy var longitude: CLLocationDegrees = 0.0098
    
    lazy var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude,
                                                                         longitude: longitude)
    
    lazy var location: CLLocation = CLLocation(latitude: coordinate.latitude,
                                               longitude: coordinate.longitude)
    
    lazy var region: MKCoordinateRegion = MKCoordinateRegion(center: coordinate,
                                                             latitudinalMeters: locationDistance,
                                                             longitudinalMeters: locationDistance)
    
    lazy var placemark: MKPlacemark = MKPlacemark(coordinate: coordinate)

    lazy var mapItem: MKMapItem = MKMapItem(placemark: placemark)
    
    private var locationDistance: CLLocationDistance = 500
    
    mutating func update(with location: CLLocation){
        
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        
        self.location = location
        self.coordinate = location.coordinate
        
        self.region = MKCoordinateRegion(center: self.coordinate,
                                         latitudinalMeters: locationDistance,
                                         longitudinalMeters: locationDistance)
        
        self.placemark = MKPlacemark(coordinate: location.coordinate)
        self.mapItem = MKMapItem(placemark: self.placemark)
        
    }
    
//    mutating func update(with placemark: MKPlacemark) {
//        
//        self.latitude = placemark.coordinate.latitude
//        self.longitude = placemark.coordinate.longitude
//        self.coordinate = placemark.coordinate
//        
//        self.location = CLLocation(latitude: self.latitude,
//                                   longitude: self.longitude)
//        
//        self.region = MKCoordinateRegion(center: self.coordinate,
//                                         latitudinalMeters: locationDistance,
//                                         longitudinalMeters: locationDistance)
//        
//        self.mapItem = MKMapItem(placemark: placemark)
//        
//    }
    
}
