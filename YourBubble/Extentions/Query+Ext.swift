//
//  Query+Ext.swift
//  YourBubble
//
//  Created by Tazo Gigitashvili on 16.08.23.
//

import Foundation
import Firebase
import FirebaseFirestore

extension Query {
    
    func getDocuments<T>(as type: T.Type) async throws -> [T] where T : Decodable {
        let snapshot = try await self.getDocuments()
        
        return try snapshot.documents.compactMap({ document in
            let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
            let object = try JSONDecoder().decode(T.self, from: jsonData)
            return object
//            try document.data(as: T.self)
        })
    }
}


