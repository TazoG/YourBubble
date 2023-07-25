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
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var shouldDismiss = false
    
    
    func signIn() async {
        guard !email.isEmpty, !password.isEmpty else {
            self.alertTitle = "Sign In Error"
            self.alertMessage = "Email or password is empty"
            self.showAlert = true
            return
        }
        
        do {
            try await AuthenticationManager.shared.signInUser(email: email, password: password)
            shouldDismiss = true
        } catch {
            self.alertTitle = "Sign In Error"
            self.alertMessage = error.localizedDescription
            self.showAlert = true
        }
    }
    
}
