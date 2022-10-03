//
//  User.swift
//  swiftui-tutorial
//
//  Created by Abdulaziz Albahar on 10/1/22.
//

import Foundation

struct User: Codable {
    
    var uuid: String
    var notes: [Note]
    
    init(uuid: String, notes: [Note]) {
        self.uuid = uuid
        self.notes = notes
    }
    
    mutating func append(text: String) {
        notes.append(Note(text: text, id: notes.endIndex + 1))        
    }
    
}
