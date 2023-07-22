//
//  SettingsViewModel.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 22.07.23.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}
