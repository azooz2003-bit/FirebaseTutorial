//
//  Notes.swift
//  swiftui-tutorial
//
//  Created by Amit Kulkarni on 9/17/22.
//

import Foundation

class Notes: ObservableObject {
    
    @Published var notes: [Note] // MUST BE PUBLISHED
    
    init() {
        self.notes = []
    }
    
    
    
}
