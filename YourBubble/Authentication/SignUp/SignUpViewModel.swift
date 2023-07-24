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
    @Published var profession = ""
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    func signUp() async throws {
        
        guard !email.isEmpty, !password.isEmpty, password == repeatPassword, password.count >= 6, !profession.isEmpty else {
            self.alertTitle = "Sign Up Error"
            self.alertMessage = "All fields are required, password must be at least 6 characters, and a profession must be selected"
            self.showAlert = true
            return
        }
        
        try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    var isSignUpEnabled: Bool {
        !email.isEmpty && !password.isEmpty && password == repeatPassword && password.count >= 6 && !profession.isEmpty
    }
}
