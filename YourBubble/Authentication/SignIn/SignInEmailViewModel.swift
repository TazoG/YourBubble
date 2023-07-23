//
//  SignInEmailViewModel.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 22.07.23.
//

import Foundation
import FirebaseAuth

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var repeatPassword = ""
    
    
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("Email or password is empty")
            return
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
    
    
}
