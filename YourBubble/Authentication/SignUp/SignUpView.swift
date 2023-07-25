//
//  SignUpView.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 23.07.23.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel = SignUpViewModel()
    @State private var profileImage: Image? = Image(systemName: "person.crop.circle")
    @Binding var showSignInView: Bool
    let professionOptions = ["IT", "Real Estate", "Financist"]
    
    var body: some View {
        VStack {
            Button(action: {
                // Add your action here to pick an image
            }) {
                profileImage?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            }
            .padding()
            
            TextField("Full Name...", text: $viewModel.fullName)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Repeat Password...", text: $viewModel.repeatPassword)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            pickerBody
            
            Button {
                Task {
                  
                   try await viewModel.signUp()
                }
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
//            .disabled(!viewModel.isSignUpEnabled)
            
            Spacer()
        }
        .shadow(radius: 10, y: 5)
        .padding(.horizontal)
        .navigationTitle("Sign up with Email")
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        .onChange(of: viewModel.forLogIn) { newValue in
            showSignInView = !newValue
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpView(showSignInView: .constant(false))
        }
    }
}

extension SignUpView {
    var pickerBody: some View {
        
        Menu {
            ForEach(professionOptions, id: \.self) { option in
                Button(option) {
                    viewModel.profession = option
                }
            }
        } label: {
            Text(viewModel.profession.isEmpty ? "Select you profession" : viewModel.profession)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(10)
        }
    }
}
