//
//  SearchViewController+Data.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/20/22.
//
import UIKit

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let delegate = delegate {
            let result = getSearchResult(with: indexPath.row)
            delegate.searchViewControllerDelegateFunc(with: result)
        }
        
        print("didSelectRowAt")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sizeSearchResults()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        let result  = getSearchResult(with: indexPath.row)
        
        let name    = result.name
        let country = result.country
        
        content.text = "\(name ?? ""), \(country ?? "")"
        
        cell.contentConfiguration = content
        
        return cell
    }
}
