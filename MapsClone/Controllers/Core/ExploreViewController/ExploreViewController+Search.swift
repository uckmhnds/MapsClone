//
//  ExploreViewController+Search.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/20/22.
//
import UIKit
import MapKit

extension ExploreViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        searchController.searchResultsController?.view.isHidden = false
        
//        toggleSearchResultsVisibility()
        
        let searchBar   = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchViewController
        else { return }
            
//        guard let text = query.text else { return }
//        showMapRoute = true
//        destinationTextField.endEditing(true)
        
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(query) { placemarks, err in
            
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            guard let placemarks = placemarks else {return}
            
            resultsController.setSearchResults(with: placemarks)
        }
        
        // To access SearchResultsViewControllerDelegate via the protocol
        resultsController.delegate  = self
        
    }
    
}
