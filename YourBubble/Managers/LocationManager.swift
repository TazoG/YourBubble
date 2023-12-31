//
//  LocationManager.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 30.07.23.
//

import Foundation
import CoreLocation
import FirebaseFirestore
import FirebaseAuth

class LocationManager: NSObject, ObservableObject {
    let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    static let shared = LocationManager()
    
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 5000
        requestLocation()
        manager.allowsBackgroundLocationUpdates = true
        manager.pausesLocationUpdatesAutomatically = false
        manager.startMonitoringSignificantLocationChanges()
    }
    
    func requestLocation() {
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else if manager.authorizationStatus == .authorizedWhenInUse {
            manager.requestAlwaysAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("TAZO: Your location is restricted")
        case .denied:
            print("TAZO: You have denied this app permission. Go into settings and turn it on please")
        case .authorizedAlways:
            manager.startUpdatingLocation()
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
        
        Task {
            do {
                if let userId = Auth.auth().currentUser?.uid {
                    try await UserManager.shared.updateLocation(userId: userId, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                }
            } catch {
                print("Failed to update location in Firebase: \(error)")
            }
        }
//
//        manager.stopUpdatingLocation()
//
//        DispatchQueue.global().asyncAfter(deadline: .now() + 3600) {
//            self.manager.startUpdatingLocation()
//        }
        
        print("TAZO: \(locations)")
    }
}
