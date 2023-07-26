//
//  UserManager.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 26.07.23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    static let shared = UserManager()
    
    private init() {}
    
    func createNewUser(auth: AuthDataResultModel) async throws {
        var userData: [String: Any] = [
            "userId": auth.uid,
            "email": auth.email as Any,
            "photoUrl": auth.photoUrl as Any
        ]
        
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
}
