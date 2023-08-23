//
//  UserManager.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 26.07.23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import CoreLocation
import GeoFire

final class UserManager {
    static let shared = UserManager()
    
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func createNewUser(auth: AuthDataResultModel, fullName: String, profession: String) async throws {
        let userData: [String: Any] = [
            "userId": auth.uid,
            "fullName": fullName,
            "email": auth.email as Any,
            "profession": profession,
            "photoUrl": auth.photoUrl as Any
        ]

        try await userDocument(userId: auth.uid).setData(userData, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        let snapshot = try await userDocument(userId: userId).getDocument()
        
        guard let data = snapshot.data(),
              let userId = data["userId"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        let fullName = data["fullName"] as? String
        let email = data["email"] as? String
        let profession = data["profession"] as? String
        let photoUrl = data["photoUrl"] as? String
        let latitude = data["latitude"] as? Double
        let longitude = data["longitude"] as? Double
        
        return DBUser(userId: userId, fullName: fullName, email: email, profession: profession, photoUrl: photoUrl, latitude: latitude, longitude: longitude)
    }
    
    func updateLocation(userId: String, latitude: Double, longitude: Double) async throws {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let hash = GFUtils.geoHash(forLocation: location)
        
        
        let locationData: [String: Any] = [
            "latitude": latitude,
            "longitude": longitude,
            "geohash" : hash
        ]
        
        try await userDocument(userId: userId).updateData(locationData)
    }
    
    func getUsersNearbyCurrentUser() async throws -> [DBUser] {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw UserManagerError.noProfessionFound
        }
        
        let currentUser = try await getUser(userId: userId)
        
        guard
            let currentUserLat = currentUser.latitude,
            let currentUserLng = currentUser.longitude else {
            throw UserManagerError.noLocationFound
        }
        
        let center = CLLocationCoordinate2D(latitude: currentUserLat, longitude: currentUserLng)
        let radiusInM: Double = 1000
        
        let queryBounds = GFUtils.queryBounds(forLocation: center, withRadius: radiusInM)
        let queries = queryBounds.map { bound -> Query in
            return userCollection
                .order(by: "geohash")
                .start(at: [bound.startValue])
                .end(at: [bound.endValue])
        }
        
        var nearbyUsers: [DBUser] = []
        
        for query in queries {
            let users: [DBUser] = try await query.getDocuments(as: DBUser.self)
            
            for user in users {
                guard let lat = user.latitude, let lng = user.longitude else { continue }
                let coordinates = CLLocation(latitude: lat, longitude: lng)
                let centerPoint = CLLocation(latitude: center.latitude, longitude: center.longitude)
                
                let distance = GFUtils.distance(from: centerPoint, to: coordinates)
                if distance <= radiusInM {
                    nearbyUsers.append(user)
                }
            }
        }
        
        return nearbyUsers
    }
    
//    func getUsersWithSameProfession(asCurrentUser userId: String) async throws -> [DBUser] {
//        let currentUser = try await getUser(userId: userId)
//        guard let profession = currentUser.profession else {
//            throw UserManagerError.noProfessionFound
//        }
//
//        let query = userCollection.whereField("profession", isEqualTo: profession)
//
//        let users = try await query.getDocuments(as: DBUser.self)
//
//        return users
//    }
}
