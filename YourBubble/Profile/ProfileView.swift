//
//  ProfileView.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 25.07.23.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    @State private var selectedUser: DBUser? = nil
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                GoogleMapView(users: viewModel.nearbyUsers, selectedUser: $selectedUser, centerCoordinate: viewModel.userLocation)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        Task {
                            do {
                                try await viewModel.loadCurrentUser()
                                viewModel.loadNearbyUsers()
                            } catch {
                                print("Error fetching user data: \(error)")
                            }
                        }
                        
                    }
            }
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
