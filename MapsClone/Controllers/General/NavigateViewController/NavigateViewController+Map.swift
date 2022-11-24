//
//  NavigateViewController+Map.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/25/22.
//

import MapKit

extension NavigateViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
          
        return renderer
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//        if annotation is MKUserLocation {
//            
//            return nil
//            
//        }else {
//
//            let Identifier      = "mappin"
//
//            let annotationView  = mapView.dequeueReusableAnnotationView(withIdentifier: Identifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: Identifier)
//
//            annotationView.canShowCallout   = true
//
//            let config                      = UIImage.SymbolConfiguration(weight: .heavy)
//
//            annotationView.image            = UIImage(systemName: "mappin", withConfiguration: config)
//
//
//            return annotationView
//
//        }
//        
//    }
}
