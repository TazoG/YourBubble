//
//  YourBubbleApp.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 22.07.23.
//

import SwiftUI
import FirebaseCore
import GoogleMaps

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let locationManager = LocationManager.shared
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        GMSServices.provideAPIKey("AIzaSyB0x7uAVx2bFJJ_HVQE95h3mM3iA-BpOI0")
        
        if let _ = launchOptions?[UIApplication.LaunchOptionsKey.location] {
            locationManager.manager.startUpdatingLocation()
        }
        
        return true
    }
}

@main
struct YourBubbleApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
