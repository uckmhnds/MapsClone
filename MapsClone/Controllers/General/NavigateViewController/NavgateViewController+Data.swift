//
//  NavgateViewController+Data.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/20/22.
//

import UIKit

extension NavigateViewController: UITableViewDataSource, UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let stackView   = UIStackView(arrangedSubviews: [searchBarTop, searchBarBottom, navigateButton])
//
//        stackView.axis  = .vertical
//
//        return stackView
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        let placemark   = searchResults[indexPath.row]
        
        let name        = placemark.name
        let country     = placemark.country
        
        
        searcherSearchBar.searchTextField.text = "\(name ?? ""), \(country ?? "")"
        
        if searcherSearchBar.accessibilityLabel == "searchBarTop"{
            
//            delegate?.setStartLocation(with: placemark)
            
            userLocation.update(with: placemark.location ?? userLocation.location)
            
        }else if searcherSearchBar.accessibilityLabel == "searchBarBottom"{
            
//            delegate?.setDestinationLocation(with: placemark)
            
            searchedLocation.update(with: placemark.location ?? searchedLocation.location)
            
        }
        
        isSeachingAnyPlace = false
        toggleContainerViewChildView()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResults.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        let name    = searchResults[indexPath.row].name
        let country = searchResults[indexPath.row].country
        
        content.text = "\(name ?? ""), \(country ?? "")"
        
        cell.contentConfiguration = content
        
        return cell
    }
}
