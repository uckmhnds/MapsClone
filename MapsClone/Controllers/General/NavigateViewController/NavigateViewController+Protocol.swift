//
//  NavigateViewController+Protocol.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/20/22.
//

import MapKit

protocol NavigateViewControllerDelegate: AnyObject {
    
    func setStartLocation(with placemark: CLPlacemark)
    
    func setDestinationLocation(with placemark: CLPlacemark)
    
    func setExplorerRoute()
    
}
