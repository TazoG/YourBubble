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
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            print("Email or password is empty")
            return
        }
        
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print(returnedUserData)
                print("Success")
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
