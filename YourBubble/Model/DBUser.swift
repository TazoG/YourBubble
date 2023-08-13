//
//  DBUser.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 26.07.23.
//

import Foundation

struct DBUser: Codable {
    let userId: String
    let fullName: String?
    let email: String?
    let profession: String?
    let photoUrl: String?
    var latitude: Double?
    var longitude: Double?
}
