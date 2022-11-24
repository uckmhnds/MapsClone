//
//  ExploreViewController+Map.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/20/22.
//

import MapKit

extension ExploreViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
          
        return renderer
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        
        let locLat  = userLocation.latitude
        let locLon  = userLocation.longitude
        
        let mapLat  = mapView.region.center.latitude
        let mapLon  = mapView.region.center.longitude
        
        let errLat  = (mapLat - locLat) / mapLat
        let errLon  = (mapLon - locLon) / mapLon
        let err     = abs(errLat) + abs(errLon)
        #warning("toggleIsNotWorking")
        if abs(err) < 1e-10 {
            isVisibleRegionCurrent          = true
            toggleLocateButton()
        }else {
            isVisibleRegionCurrent          = false
            toggleLocateButton()
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if annotation is MKUserLocation {
            
            return nil
            
        }else {

            let Identifier      = "mappin"

            let annotationView  = mapView.dequeueReusableAnnotationView(withIdentifier: Identifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: Identifier)

            annotationView.canShowCallout   = true

            let config                      = UIImage.SymbolConfiguration(weight: .heavy)

            annotationView.image            = UIImage(systemName: "mappin", withConfiguration: config)


            return annotationView

        }
        
    }

    
}
