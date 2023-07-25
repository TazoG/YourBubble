//
//  SignInEmailView.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 22.07.23.
//

import SwiftUI

struct SignInEmailView: View {
    
    @StateObject var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                Task {
                    
                    await viewModel.signIn()

                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
            
            HStack {
                Text("Don't you have an account?")
                
                NavigationLink("Sign Up!") {
                    SignUpView(showSignInView: $showSignInView)
                }
            }
            .padding()
            
            
        }
        .shadow(radius: 10, y: 5)
        .padding()
        .navigationTitle("Sign In With Email")
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        .onChange(of: viewModel.shouldDismiss) { newValue in
            showSignInView = !newValue
        }
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInEmailView(showSignInView: .constant(false))
        }
    }
}
