//
//  Notes.swift
//  swiftui-tutorial
//
//  Created by Amit Kulkarni on 9/17/22.
//

import Foundation

class Notes: ObservableObject {
    @Published var notes: [Note] = []
    
    func append(text: String) {
        notes.append(Note(text: text, id: notes.endIndex + 1))
    }
}
