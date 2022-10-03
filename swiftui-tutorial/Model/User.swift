//
//  User.swift
//  swiftui-tutorial
//
//  Created by Abdulaziz Albahar on 10/1/22.
//

import Foundation

struct User {
    
    var uuid: String
    var notes: Notes
    
    init(uuid: String) {
        self.uuid = uuid
        self.notes = Notes()
    }
    
    
}
