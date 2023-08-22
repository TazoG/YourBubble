//
//  Query+Ext.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 16.08.23.
//

import Foundation
import Firebase

extension Query {
    
    func getDocuments<T>(as type: T.Type) async throws -> [T] where T : Decodable {
        let snapshot = try await self.getDocuments()
        
        return try snapshot.documents.compactMap({ document in
            try document.data(as: T.self)
        })
    }
}
