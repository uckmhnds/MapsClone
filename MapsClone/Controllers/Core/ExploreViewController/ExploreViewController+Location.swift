//
//  ExploreViewController+Location.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/20/22.
//
import CoreLocation

extension ExploreViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !showMapRoute{
            if let location = locations.last {
                
                self.userLocation.update(with: location)
                self.centerViewToUserLocation()
                
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleAuthorizationStatus(locationManager: manager, status: status)
    }
    
}
