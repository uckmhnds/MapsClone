//
//  SearchViewController+Protocol.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/20/22.
//

import MapKit

protocol SearchViewControllerDelegate: AnyObject {
    func searchViewControllerDelegateFunc(with placemark: CLPlacemark)
}
