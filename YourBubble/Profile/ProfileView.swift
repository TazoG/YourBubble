//
//  ProfileView.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 25.07.23.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    @State var changeProfileImage = false
    @State var openCameraRoll = false
    @State var imageSelected = UIImage()
    @State private var profileImage: Image? = Image(systemName: "person.crop.circle")
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack {
            Color.cyan.opacity(0.4).ignoresSafeArea()
            
            VStack {
                Button(action: {
                    changeProfileImage = true
                    openCameraRoll = true
                }) {
                    if changeProfileImage {
                        Image(uiImage: imageSelected)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .cornerRadius(75.0)
                    } else {
                        profileImage?
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white.opacity(0.4), lineWidth: 4))
                            .shadow(color: .black.opacity(0.1), radius: 10)
                    }
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 15.0) {
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
                Spacer()
            }
            .sheet(isPresented: $openCameraRoll, content: {
                ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
            })
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
