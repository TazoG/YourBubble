//
//  Error.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 17.08.23.
//

import Foundation

enum UserManagerError: Error {
    case noProfessionFound
    case noAuthenticatedUser
    case noLocationFound
    case customError(String)
}
