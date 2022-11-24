//
//  ExploreViewController.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/18/22.
//

import UIKit
import MapKit
import CoreLocation

class ExploreViewController: UIViewController {
    
//    internal var route: MKRoute?
//    internal var routeDistance: CLLocationDistance?
//    internal var routeTime: TimeInterval?
//    internal var transportType: MKDirectionsTransportType?

    internal var showMapRoute            = false
    internal var navigationStarted       = false
    internal var isVisibleRegionCurrent  = false
    
//    internal var currentCoordinate: CLLocationCoordinate2D?
//    internal var currentRegion: MKCoordinateRegion?
//    internal var currentLocation: CLLocation?
    
//    internal var startCoordinate: CLLocationCoordinate2D?
//    internal var startRegion: MKCoordinateRegion?
//    internal var startLocation: CLLocation?
    
//    internal var destinationCoordinate: CLLocationCoordinate2D?
//    internal var destinationRegion: MKCoordinateRegion?
//    internal var destinationLocation: CLLocation?
    
//    internal let locationDistance: Double = 500
    
    ///
    ///
    ///
    internal var isUserRegionVisibleRegion = false
    
    internal var userLocation = Location()
    
    internal var searchedLocation = Location()
    
    internal var transportType: MKDirectionsTransportType = .automobile
    
    internal var routeTime: String = ""
    
    internal var routeDistance: String = ""
    
    private lazy var locationManager: CLLocationManager = {

        let locationManager = CLLocationManager()

        Task { [weak self] in

            if ((await self?.isLocationServiceEnabled()) != nil) {

                locationManager.delegate            = self
                locationManager.desiredAccuracy     = kCLLocationAccuracyBest
                handleAuthorizationStatus(locationManager: locationManager, status: CLLocationManager.authorizationStatus())

            }

        }

        return locationManager
    }()
    
    private lazy var searchController: UISearchController = {
        
        let controller                                          = UISearchController(searchResultsController: SearchViewController())
        
        controller.automaticallyShowsSearchResultsController    = true
        controller.searchBar.placeholder                        = "Find a place"
        controller.searchBar.searchBarStyle                     = .default
        controller.searchBar.layer.cornerRadius                 = 10
        controller.searchBar.searchTextField.backgroundColor    = .systemGray
        controller.searchBar.barTintColor                       = .blue
        controller.searchBar.isTranslucent                      = false
        controller.searchBar.tintColor                          = .blue
        
        return controller
        
    }()
    
    private lazy var locateButton: UIButton = {
        
        let action                                          = UIAction { action in
            
            self.centerViewToUserLocation()
            
        }
        
        let button                                          = UIButton(primaryAction: action)
        let config                                          = UIImage.SymbolConfiguration(weight: .bold)
        let image                                           = UIImage(systemName: "scope", withConfiguration: config)
        
        button.setImage(image, for: .normal)
        
        button.imageView?.contentMode                       = .scaleAspectFit
        button.layer.cornerRadius                           = 25
        button.translatesAutoresizingMaskIntoConstraints    = false
        button.backgroundColor                              = .white
        
        return button
        
    }()
    
    private lazy var navigateButton: UIButton = {
        
        let action                                          = UIAction { _ in
            
            let viewController                              = NavigateViewController()
            viewController.delegate                         = self
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        let button                                          = UIButton(primaryAction: action)
        
        let config                                          = UIImage.SymbolConfiguration(weight: .bold)
        let image                                           = UIImage(systemName: "arrow.triangle.turn.up.right.diamond.fill", withConfiguration: config)
        
        button.setImage(image, for: .normal)
        
        button.imageView?.contentMode                       = .scaleAspectFit
        button.layer.cornerRadius                           = 10
        button.translatesAutoresizingMaskIntoConstraints    = false
        button.backgroundColor                              = .blue
        return button
        
    }()
    
    private lazy var mapView: MKMapView = {
        
        let mapView                 = MKMapView(frame: view.bounds)
        
        mapView.showsCompass = true
        mapView.showsUserLocation   = true
        
        return mapView
        
    }()
    
    private func appylConstraints() {
        
        let locateButtonConstraints = [
            
            locateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            locateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            locateButton.heightAnchor.constraint(equalToConstant: 50),
            locateButton.widthAnchor.constraint(equalToConstant: 50)
            
        ]
        
        let navigateButtonConstraints = [
            
            navigateButton.centerXAnchor.constraint(equalTo: locateButton.centerXAnchor),
            navigateButton.topAnchor.constraint(equalTo: locateButton.bottomAnchor, constant: 20),
            navigateButton.heightAnchor.constraint(equalToConstant: 50),
            navigateButton.widthAnchor.constraint(equalToConstant: 50)
            
        ]
        
        
        NSLayoutConstraint.activate(locateButtonConstraints)
        NSLayoutConstraint.activate(navigateButtonConstraints)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        view.addSubview(mapView)
        view.addSubview(locateButton)
        view.addSubview(navigateButton)
        
        appylConstraints()
        
        locationManager.startUpdatingLocation()
        
        searchController.searchResultsUpdater   = self
        mapView.delegate                        = self
        
        navigationItem.searchController         = searchController
        
    }
    
    private func isLocationServiceEnabled() async -> Bool {
        CLLocationManager.locationServicesEnabled()
    }
    
    internal func handleAuthorizationStatus(locationManager: CLLocationManager, status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            //
            break
        case .denied:
            //
            break
        case .authorizedAlways:
            //
            break
        case .authorizedWhenInUse:
            
            if let location = locationManager.location {
                
                updateUserLocation(with: location)
                
            }
            
            break
        @unknown default:
            //
            break
        }
    }
    
    internal func updateUserLocation(with location: CLLocation){
        
        userLocation.update(with: location)
        
    }
    
    internal func updateSearchedLocation(with location: CLLocation){
        
        searchedLocation.update(with: location)
        
    }
    
    internal func centerViewToUserLocation() {
        
        mapView.setRegion(userLocation.region, animated: true)
        
    }
    
    internal func centerViewToSearchedLocation() {
        
        let annotation          = MKPointAnnotation()
        annotation.coordinate   = searchedLocation.coordinate
        annotation.title        = ""
        annotation.subtitle     = ""
        
        if let lastAnnotation = mapView.annotations.last {
            
            if lastAnnotation is MKUserLocation {
                mapView.addAnnotation(annotation)
            }else{
                mapView.removeAnnotation(lastAnnotation)
                mapView.addAnnotation(annotation)
            }
            
        }
        
        mapView.setRegion(searchedLocation.region,
                          animated: true)
        
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
                    
                    let timeFormatter = DateComponentsFormatter()
                    timeFormatter.allowedUnits = [.day, .hour, .minute, .second]
                    timeFormatter.unitsStyle = .short
                    timeFormatter.maximumUnitCount = 2
                    
                    let routeAnnotation             = MKPointAnnotation()
                    routeAnnotation.title           = timeFormatter.string(from: route.expectedTravelTime)
                    routeAnnotation.coordinate      = route.polyline.points()[route.polyline.pointCount/2].coordinate
                    
                    self?.mapView.addAnnotation(routeAnnotation)
                    
                }
                
                
            case .failure(let err):
//                #warning("exception handler")
                print(err.localizedDescription)
            }
        }
    }
    
    internal func toggleSearchResultsVisibility(){
        
        searchController.searchResultsController?.view.isHidden.toggle()
        
    }
    
    internal func toggleLocateButton(){
        
        if locateButton.backgroundColor == .systemGray {
            
            locateButton.backgroundColor = .white
            
        }else if locateButton.backgroundColor == .white {
            
            locateButton.backgroundColor = .systemGray
            
        }else {
            
            return
            
        }
        
    }
    
}

