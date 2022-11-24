//
//  NavigateViewController+Search.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/20/22.
//
import UIKit
import MapKit

extension NavigateViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        if searchBar.accessibilityLabel == "searchBarTop"{
            searcherSearchBar = searchBarTop
        }else if searchBar.accessibilityLabel == "searchBarBottom"{
            searcherSearchBar = searchBarBottom
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty &&
            searchText.trimmingCharacters(in: .whitespaces).count >= 3 {

            let geoCoder = CLGeocoder()

            geoCoder.geocodeAddressString(searchText) { placemarks, err in

                if let err = err {
                    print(err.localizedDescription)
                    return
                }

                guard let placemarks = placemarks else {return}

                self.setSearchResults(with: placemarks)

                self.tableView.reloadData()
            }
        }else if searchText.count == 0{
            
            isSeachingAnyPlace = false
            toggleContainerViewChildView()
            
        }else{
            
            isSeachingAnyPlace = true
            toggleContainerViewChildView()
            
            return
        }
        
    }
    
}
