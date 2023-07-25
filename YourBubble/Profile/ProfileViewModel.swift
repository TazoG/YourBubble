//
//  ProfileViewModel.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 25.07.23.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: AuthDataResultModel? = nil
    
    func loadCurrentUser() throws {
        self.user = try AuthenticationManager.shared.getAuthenticatedUser()
    }
    
}
