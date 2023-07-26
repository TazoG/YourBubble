//
//  ProfileView.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 25.07.23.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            
            VStack {
                if let user = viewModel.user {
                    Text("UserId: \(user.userId)")
                    
                    if let fullName = user.fullName {
                        Text("User's full name is \(fullName.capitalized)")
                    }
                    
                    if let profession = user.profession {
                        Text("User's profession is \(profession.capitalized)")
                    }
                }
            }
            .task {
                try? await viewModel.loadCurrentUser()
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingsView(showSignInView: $showSignInView)
                    } label: {
                        Image(systemName: "gear")
                            .font(.headline)
                    }
                }
        }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView(showSignInView: .constant(false))
        }
    }
}
