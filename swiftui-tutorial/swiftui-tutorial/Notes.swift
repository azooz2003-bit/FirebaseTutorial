//
//  Notes.swift
//  swiftui-tutorial
//
//  Created by Amit Kulkarni on 9/17/22.
//

import Foundation
import Firebase

class Notes: ObservableObject {
    @Published var notes: [Note] = []
    
    init() {
        fetchNotes()
    }
    
    func fetchNotes() {
        notes.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("notes")
        
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let text = data["text"] as? String ?? ""
                    let id = data["id"] as? Int ?? 0
                    
                    let note = Note(text: text, id: id)
                    self.notes.append(note)
                }
            }
            
        }
    }
    
    func addNotes(text: String) {
        let db = Firestore.firestore()
        let ref = db.collection("notes").document(text)
        ref.setData(["text": text, "id": notes.endIndex + 1]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
//        notes.append(Note(text: text, id: notes.endIndex + 1))
    }
}
