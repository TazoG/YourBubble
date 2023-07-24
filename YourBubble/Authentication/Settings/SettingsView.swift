//
//  SettingsView.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 22.07.23.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            emailSection
            
            logOutButton
            
            deleteAccount
        }
    }
}

private extension SettingsView {
    var logOutButton: some View {
        Button("Log Out") {
            Task {
                do {
                    try viewModel.signOut()
                    showSignInView = true
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        .foregroundColor(.red)
    }
    
    var emailSection: some View {
        Section {
            Button("Reset Password") {
                viewModel.resetPassword()
            }
            
            Button("Update Password") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("Password Updated!")
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            
            Button("Update Email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("Email Updated!")
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        } header: {
            Text("Account Functions")
        }
    }
    
    var deleteAccount: some View {
        Button(role: .destructive) {
            Task {
                do {
                    try await viewModel.deleteAccount()
                    showSignInView = true
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } label: {
            Text("Delete Account")
        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(showSignInView: .constant(false))
        }
    }
}
