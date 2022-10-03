//
//  ContentView.swift
//  swiftui-tutorial
//
//  Created by Nicolas Rios on 9/17/22.
//

import SwiftUI

struct ContentView: View {
    //let dim = UIScreen.main.bounds
    
//    @ObservedObject var notes: Notes = Notes()
    @EnvironmentObject var Notes: Notes
    @State var newNote = ""
    @State var isEmpty = false
    
    
    var body: some View {
                
        VStack {
            Text("Notes App").font(.system(size: 40, design: .rounded)).bold()
            ScrollView {                
                ForEach(notes.notes, id: \.self.id) { note in
//                    Text("as")
                    Card(text: note.text)
                    
                }
            }
            
            HStack {
        
                TextField("Enter a note", text: $newNote)
                    .frame(height: 60, alignment: .center)
                    .padding()
                    .background(Color("AccentColor"))
                    .cornerRadius(7)
                    .foregroundColor(.white)

        
                Button (action: {
                    
                    if (newNote.isEmpty) {
                        isEmpty = true
                    } else {
                        notes.append(text: newNote)
                        newNote = ""
                    }
                                        
                }) {
                    Label("", systemImage: "plus.circle.fill").font(.system(size: 50)).foregroundColor(Color("AccentColor"))
                }.padding(.leading).alert("Empty note!", isPresented: $isEmpty) {
                    Button("Ok", role: .cancel) {
                        isEmpty = false
                    }
                    
                }
            }.padding(.leading).padding(.trailing)
        }.padding(.top)
        
        
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
