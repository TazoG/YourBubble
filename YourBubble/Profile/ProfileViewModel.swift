//
//  ProfileViewModel.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 25.07.23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published var nearbyUsers: [DBUser] = []
    //    @Published var usersWithSameProfession: [DBUser] = []
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func loadNearbyUsers() {
        Task {
            do {
                self.nearbyUsers = try await UserManager.shared.getUsersNearbyCurrentUser().filter {
                    $0.profession == user?.profession ?? ""
                }
            } catch {
                print("TAZO: Error fetching nearby users: \(error.localizedDescription)")
            }
        }
    }
    
    //    func loadUsersWithSameProfession() async {
    //        guard let userId = user?.userId else { return }
    //
    //        do {
    //            usersWithSameProfession = try await UserManager.shared.getUsersWithSameProfession(asCurrentUser: userId)
    //        } catch {
    //            print("Failed to load users with the same profession: \(error)")
    //        }
    //    }
}
