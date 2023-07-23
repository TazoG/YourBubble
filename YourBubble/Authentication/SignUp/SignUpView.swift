//
//  SignUpView.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 23.07.23.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel = SignUpViewModel()
    @Binding var showSignInView: Bool
    @State var selection = "Select your profession"
    let professionOptions = ["IT", "Real Estate", "Financist"]
    
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
            
            SecureField("Repeat Password...", text: $viewModel.repeatPassword)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            pickerBody
            
            Button {
                Task {
                    do {
                        try await viewModel.signUp()
                        showSignInView = true
                        return
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.trailing, 22)
            }
            .disabled(!viewModel.isSignUpEnabled)
            
            Spacer()
        }
        .shadow(radius: 10, y: 5)
        .padding(.horizontal)
        .navigationTitle("Sign up with Email")
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
        Picker(selection: $selection) {
            ForEach(professionOptions, id: \.self) { option in
                Text(option)
                    .tag(option)
            }
        } label: {
            Text("Select you profession")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
        }
        .pickerStyle(.navigationLink)
    }
}
