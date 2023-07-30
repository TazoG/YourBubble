//
//  LocationManager.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 30.07.23.
//

import Foundation
import CoreLocation

//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//
//    static let shared = LocationManager()
//    var locationManager: CLLocationManager?
//
//    func checkIfLocationServiceEnabled() {
//        if CLLocationManager.locationServicesEnabled() {
//            self.locationManager = CLLocationManager()
//            self.locationManager!.delegate = self
//        } else {
//            print("show user to let location permission turn on")
//        }
//    }
//
//    private func checkLocationAuthorization() {
//        guard let locationManager else { return }
//
//        switch locationManager.authorizationStatus {
//        case .notDetermined:
//            locationManager.requestAlwaysAuthorization()
//        case .restricted:
//            print("Your location is restricted")
//        case .denied:
//            print("You have denied this app permission. Go into settings and turn it on please")
//        case .authorizedAlways, .authorizedWhenInUse:
//            break
//        @unknown default:
//            break
//        }
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        checkLocationAuthorization()
//    }
//}

class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    static let shared = LocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    func requestLocation() {
        manager.requestAlwaysAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestAlwaysAuthorization()
        case .restricted:
            print("TAZO: Your location is restricted")
        case .denied:
            print("TAZO: You have denied this app permission. Go into settings and turn it on please")
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
    }
}
