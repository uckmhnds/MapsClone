//
//  RouteCaller.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/25/22.
//

import CoreLocation
import MapKit

struct RouteCaller{
    
    static let shared = RouteCaller()
    
    func calculateRoute(from source: MKMapItem,
                        to destination: MKMapItem,
                        by transportType: MKDirectionsTransportType,
                        completion: @escaping (Result<[MKRoute], Error>) -> Void){
        
        let request = MKDirections.Request()
            
        request.source = source
        request.destination = destination
        request.transportType = transportType
        request.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: request)
        
        directions.calculate {  response, err in
            
            
            if let err = err {
                
                completion(.failure(err))
                return
            }
            
            guard let response = response else {return}
            
            let routes = response.routes
            
            completion(.success(routes))
            
        }
    }
    
}
