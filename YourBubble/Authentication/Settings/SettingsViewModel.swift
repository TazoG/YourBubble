//
//  SettingsViewModel.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 22.07.23.
//

import Foundation
import FirebaseAuth

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() {
        Task {
            do {
                let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
                
                guard let email = authUser.email else {
                    throw URLError(.fileDoesNotExist)
                }
                
                try await AuthenticationManager.shared.resetPassword(email: email)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateEmail() async throws {
//        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws {
//        try await AuthenticationManager.shared.updatePassword(password: password)
    }
}
