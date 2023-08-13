//
//  UserManager.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 26.07.23.
//

import Foundation
import FirebaseFirestore

final class UserManager {
    static let shared = UserManager()
    
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
//    func createNewUser(user: DBUser) async throws {
//        try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: Firestore.Encoder())
//    }
    
    func createNewUser(auth: AuthDataResultModel, fullName: String, profession: String) async throws {
        let userData: [String: Any] = [
            "userId": auth.uid,
            "fullName": fullName,
            "email": auth.email as Any,
            "profession": profession,
            "photoUrl": auth.photoUrl as Any
        ]

        try await userDocument(userId: auth.uid).setData(userData, merge: false)
//        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        let snapshot = try await userDocument(userId: userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["userId"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        let fullName = data["fullName"] as? String
        let email = data["email"] as? String
        let profession = data["profession"] as? String
        let photoUrl = data["photoUrl"] as? String
        
        
        return DBUser(userId: userId, fullName: fullName, email: email, profession: profession, photoUrl: photoUrl)
    }
    
//    func updateLocation(userId: String, latitude: Double, longitude: Double) async throws {
//        let userData: [String: Any] = [
//            "userId": userId,
//            "latitude": latitude,
//            "longitude": longitude
//        ]
//        try await Firestore.firestore().collection("users").document(userId).setData(userData, merge: true)
//    }
    
    func updateLocation(userId: String, latitude: Double, longitude: Double) async throws {
        let locationData: [String: Any] = [
            "latitude": latitude,
            "longitude": longitude
        ]
//        let userRef = Firestore.firestore().collection("users").document(userId)
        try await userDocument(userId: userId).updateData(locationData)
    }
}
