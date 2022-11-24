//
//  ExploreViewController+Delegate.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/20/22.
//
import UIKit
import MapKit

extension ExploreViewController: SearchViewControllerDelegate {
    
    func searchViewControllerDelegateFunc(with placemark: CLPlacemark) {
        
//        searchController.searchResultsController?.view.isHidden = true
        
//        if let coordinate = placemark.location?.coordinate{
//            centerViewToSearchedLocation(center: coordinate)
//        }
        toggleSearchResultsVisibility()
        
        if let location = placemark.location{
            
            self.searchedLocation.update(with: location)
            centerViewToSearchedLocation()
            
        }
        
    }
    
}

extension ExploreViewController: NavigateViewControllerDelegate {
    
    func setStartLocation(with placemark: CLPlacemark) {
        
        userLocation.update(with: placemark.location ?? userLocation.location)
        
    }
    
    func setDestinationLocation(with placemark: CLPlacemark) {
        
        searchedLocation.update(with: placemark.location ?? searchedLocation.location)
        
    }
    
    func setExplorerRoute() {
        
        self.setRoute()
        
    }
    
    
}
