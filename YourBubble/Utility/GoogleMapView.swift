//
//  GoogleMapView.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 25.08.23.
//

import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    var users: [DBUser]
    @Binding var selectedUser: DBUser?
    var centerCoordinate: CLLocationCoordinate2D?
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: centerCoordinate?.latitude ?? 0,
                                              longitude: centerCoordinate?.longitude ?? 0, zoom: 15)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        if let coordinate = centerCoordinate {
            let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude,
                                                  longitude: coordinate.longitude, zoom: 15)
            uiView.animate(to: camera)
        }
        
        uiView.clear()
        for user in users {
            guard let latitude = user.latitude, let longitude = user.longitude else { continue }
            let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let marker = GMSMarker(position: position)
            marker.map = uiView
            print("TAZO: Added marker for user: \(user) at position: \(position)")
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: GoogleMapView
        
        init(_ parent: GoogleMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            if let user = marker.userData as? DBUser {
                parent.selectedUser = user
            }
            return true
        }
    }
}
