//
//  NavigateViewController.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/18/22.
//

import UIKit
import MapKit
import CoreLocation

class NavigateViewController: UIViewController {
    
    internal var userLocation = Location()
    
    internal var searchedLocation = Location()
    
    internal var transportType: MKDirectionsTransportType = .automobile {
        
        didSet {
            carButton.setNeedsUpdateConfiguration()
            publicTransportationButton.setNeedsUpdateConfiguration()
            walkButton.setNeedsUpdateConfiguration()
        }
        
    }
    
    internal var isSeachingAnyPlace: Bool = false
    
    var delegate: NavigateViewControllerDelegate?
    
    internal var searchResults: [CLPlacemark] = [CLPlacemark]()
    
    internal lazy var searchBarTop: UISearchBar = {
        let searchBar           = searchBar()
        searchBar.accessibilityLabel = "searchBarTop"
        searchBar.placeholder   = "Your Location"
        return searchBar
    }()
    
    internal lazy var searchBarBottom: UISearchBar = {
        let searchBar           = searchBar()
        searchBar.accessibilityLabel = "searchBarBottom"
        searchBar.placeholder   = "Destination Location"
        return searchBar
    }()
    
    internal lazy var searcherSearchBar = searchBarBottom
    
    internal lazy var carButton: UIButton = {
        
        let action = UIAction { _ in
            self.transportType = MKDirectionsTransportType.automobile
        }
        
        let button = UIButton(primaryAction: action)
        
        button.configurationUpdateHandler = {
            
            [unowned self] button in

            var config              = self.transportType == MKDirectionsTransportType.automobile ? UIButton.Configuration.filled() : UIButton.Configuration.gray()
            config.image            = self.transportType == MKDirectionsTransportType.automobile ? UIImage(systemName: "car.fill") : UIImage(systemName: "car")
            button.configuration    = config
            
        }
        
        return button
    }()
    
    internal lazy var publicTransportationButton: UIButton = {
        
        let action = UIAction { _ in
            self.transportType = MKDirectionsTransportType.transit
        }
        
        let button = UIButton(primaryAction: action)
        
        button.configurationUpdateHandler = {
            
            [unowned self] button in

            var config              = self.transportType == MKDirectionsTransportType.transit ? UIButton.Configuration.filled() : UIButton.Configuration.gray()
            config.image            = self.transportType == MKDirectionsTransportType.transit ? UIImage(systemName: "tram.fill") : UIImage(systemName: "tram")
            button.configuration    = config
            
        }
        
        return button
    }()
    
    internal lazy var walkButton: UIButton = {
        
        let action = UIAction { _ in
            self.transportType = MKDirectionsTransportType.walking
        }
        
        let button = UIButton(primaryAction: action)
        
        button.configurationUpdateHandler = {
            
            [unowned self] button in

            var config              = self.transportType == MKDirectionsTransportType.walking ? UIButton.Configuration.filled() : UIButton.Configuration.gray()
            config.image            = self.transportType == MKDirectionsTransportType.walking ? UIImage(systemName: "figure.walk.circle.fill") : UIImage(systemName: "figure.walk.circle")
            button.configuration    = config
            
        }
        
        return button
    }()
    
    private lazy var transportTypeStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [carButton, publicTransportationButton, walkButton])
        view.alignment = .fill
        view.spacing = 12
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = true
        return view
    }()
    
    internal lazy var tableView: UITableView = {
        
        let view    = UITableView()
        
        view.register(UITableViewCell.self,
                      forCellReuseIdentifier: "cellId")
        
        view.isHidden = true
        
        return view
    }()
    
    internal lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.showsUserLocation = true
        map.isHidden = false
        map.delegate = self
        return map
    }()
    
    internal lazy var containerView : UIView = {
        let view = UIView()
        
        return view
    }()
    
    internal lazy var showNavigationButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "arrow.triangle.turn.up.right.diamond.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        return button
    }()
    
    internal lazy var startNavigationButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "location.north.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(testMethod), for: .touchUpInside)
        return button
    }()
    
    internal lazy var navigationStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [showNavigationButton, startNavigationButton])
        view.alignment = .center
        view.spacing = 12
        view.distribution = .fillProportionally
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        
        let view = UIStackView(arrangedSubviews: [searchBarTop,
                                                  searchBarBottom,
                                                  transportTypeStackView,
                                                  containerView,
                                                  navigationStackView])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 12
        return view
        
    }()
    
    private func applyConstraints(){
        
        let mainStackViewConstraints = [
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        let transportTypeStackViewConstraints = [
            carButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            walkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ]
        
        let navigationStackViewConstraints = [
            showNavigationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            startNavigationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ]
        
        NSLayoutConstraint.activate(mainStackViewConstraints)
        NSLayoutConstraint.activate(transportTypeStackViewConstraints)
        NSLayoutConstraint.activate(navigationStackViewConstraints)
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor     = .systemBackground
        
        tableView.dataSource     = self
        tableView.delegate       = self
        
        searchBarTop.delegate    = self
        searchBarBottom.delegate = self
        
        containerView.addSubview(mapView)
        containerView.addSubview(tableView)
        
        view.addSubview(mainStackView)
        
        applyConstraints()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mapView.frame = containerView.bounds
        tableView.frame = containerView.bounds
    }
    
    fileprivate func searchBar() -> UISearchBar {
        
        let searchBar                                       = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.isTranslucent                             = true
        searchBar.searchTextField.textColor                 = .yellow
        searchBar.searchTextField.font                      = UIFont(name: "normal", size: 16)
        
        searchBar.backgroundImage                           = UIImage(color: .clear)
        searchBar.backgroundColor                           = .clear
        
        return searchBar
    }
    
    @objc private func startStopButtonTapped(){
        
        print("startStopButtonTapped")
        
        setRoute()
        
    }
    
    private let vc = RouteTableViewController()
    
    @objc private func testMethod(){
        
        if let sheet = self.vc.sheetPresentationController{
            
            let smallestDetent = UISheetPresentationController.Detent.custom { _ in
                return 80
            }
            
            let biggestDetent = UISheetPresentationController.Detent.custom { _ in
                return 300
            }
            
            sheet.detents = [smallestDetent, biggestDetent]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.largestUndimmedDetentIdentifier = biggestDetent.identifier
        }
        
        self.present(self.vc, animated: true)
        
    }
    
    internal func  toggleContainerViewChildView(){
        mapView.isHidden = isSeachingAnyPlace ? true : false
        tableView.isHidden = isSeachingAnyPlace ? false : true
//        mapView.isHidden.toggle()
//        tableView.isHidden.toggle()
    }
    
    internal func setSearchResults(with placemarks: [CLPlacemark]){
        
        searchResults   = placemarks
        
        tableView.reloadData()
    }
    
    internal func setRoute() {
        
        RouteCaller.shared.calculateRoute(from: userLocation.mapItem,
                                          to: searchedLocation.mapItem,
                                          by: transportType) { [weak self] result in
            switch result {
                
            case .success(let routes):
                
                // Remove overlay if exist in case that another route search is performed
                if let overlays = self?.mapView.overlays{

                    self?.mapView.removeOverlays(overlays)

                }
                
                for route in routes {
                    
                    self?.mapView.addOverlay(route.polyline)

                    self?.mapView.setVisibleMapRect(route.polyline.boundingMapRect,
                                                   edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50),
                                                   animated: true)
                    
                    let timeFormatter               = DateComponentsFormatter()
                    
                    timeFormatter.allowedUnits      = [.day, .hour, .minute, .second]
                    timeFormatter.unitsStyle        = .short
                    timeFormatter.maximumUnitCount  = 2
                    
                    let routeAnnotation             = MKPointAnnotation()
                    routeAnnotation.title           = timeFormatter.string(from: route.expectedTravelTime)
                    routeAnnotation.coordinate      = route.polyline.points()[route.polyline.pointCount/2].coordinate
                    
                    self?.mapView.addAnnotation(routeAnnotation)
                    
                }
                
            case .failure(let err):
                #warning("exception handler")
                print(err.localizedDescription)
            }
        }
        
    }

}
