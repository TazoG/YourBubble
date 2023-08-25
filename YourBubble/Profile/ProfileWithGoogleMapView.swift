//
//  ProfileWithGoogleMapView.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 25.08.23.
//

import SwiftUI

struct ProfileWithGoogleMapView: View {
    
    
    var body: some View {
        @State var changeProfileImage = false
        @State var openCameraRoll = false
        @State var imageSelected = UIImage()
        @State var profileImage: Image? = Image(systemName: "person.crop.circle")
        
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
            
            
            
            
            
            Spacer()
        }
        .sheet(isPresented: $openCameraRoll, content: {
            ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
        })
        
        
        
        
        
        
        
        
        
//        @State private var users: [DBUser] = [] // Populate this with the nearby users
//        @State private var selectedUser: DBUser? = nil
//        
        
    }
    
    struct ProfileWithGoogleMapView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileWithGoogleMapView()
        }
    }
}
