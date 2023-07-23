//
//  SignUpViewModel.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 23.07.23.
//

import Foundation
import FirebaseAuth

@MainActor
final class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var repeatPassword = ""
    
    func signUp() async throws {
        
        try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    var isSignUpEnabled: Bool {
        !email.isEmpty && !password.isEmpty && password == repeatPassword
    }
}
