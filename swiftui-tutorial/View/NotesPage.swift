//
//  ContentView.swift
//  swiftui-tutorial
//
//  Created by Nicolas Rios on 9/17/22.
//

import SwiftUI

struct NotesPage: View {
    //let dim = UIScreen.main.bounds
        
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var newNote = ""
    @State var isEmpty = false
    
    var body: some View {
        let user = userViewModel.user
                
        VStack {
            Text("MyNotes").font(.system(size: 40, design: .rounded)).bold()
            ScrollView {
                
                ForEach((user?.notes ?? []), id: \.self.id) { note in
                    
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
                        userViewModel.user?.append(text: newNote)
                        
                        userViewModel.add()
                        newNote = ""
                    }
                                        
                }) {
                    Label("", systemImage: "plus.circle.fill").font(.system(size: 50)).foregroundColor(Color("AccentColor"))
                }.padding(.leading).alert("Empty note!", isPresented: $isEmpty) {
                    Button("Ok", role: .cancel) {
                        isEmpty = false
                    }
                    
                }
            }.padding()
        }.padding(.top)
        
        
            
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NotesPage()
    }
}
