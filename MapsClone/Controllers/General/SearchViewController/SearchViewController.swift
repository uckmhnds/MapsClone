//
//  SearchViewController.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/18/22.
//

import UIKit
import MapKit

class SearchViewController: UIViewController {
    
    var delegate: SearchViewControllerDelegate?
    
    private var searchResults: [CLPlacemark] = [CLPlacemark]()
    
    internal func getSearchResult(with index: Int) -> CLPlacemark{
        return searchResults[index]
    }
    
    internal func sizeSearchResults() -> Int {
        return searchResults.count
    }
    
    func setSearchResults(with placemarks: [CLPlacemark]){
        searchResults   = placemarks
        
        tableView.reloadData()
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        return table
    }()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.dataSource    = self
        tableView.delegate      = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

