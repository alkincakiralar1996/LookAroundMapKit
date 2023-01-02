//
//  MapView.swift
//  LookAroundMapKit
//
//  Created by Alkın Çakıralar on 21.11.2022.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    @Binding var tappedLocation: CLLocationCoordinate2D? // we should bind the user tapped location coordinate object for sending the lookaroundview represen
    
    @StateObject var locationManager = LocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        
        mapView.showsUserLocation = true
        
        let mapTap = UITapGestureRecognizer(target: context.coordinator, action: #selector(MapViewCoordinator.mapTapped(_:)))
        mapView.addGestureRecognizer(mapTap) // creating touch event on the mapview
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if uiView.delegate != nil { return }

        if let userLocation = locationManager.userLocation {
            uiView.setRegion(.init(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200), animated: false)
            
            uiView.delegate = context.coordinator // setting the coordinator to the MkMapView
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
         MapViewCoordinator(self, tappedLocation: $tappedLocation)
    }
}
