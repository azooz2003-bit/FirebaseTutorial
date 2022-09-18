//
//  ContentView.swift
//  swiftui-tutorial
//
//  Created by Nicolas Rios on 9/17/22.
//

import SwiftUI

struct ContentView: View {
    let dim = UIScreen.main.bounds
    
    @ObservedObject var notes: Notes = Notes()
    
    @State var newNote = ""
    
    var body: some View {
        
        VStack {
            ScrollView {
                ForEach(notes.notes, id: \.self.id) { note in
//                    Text("as")
                    Card(text: note.text)
                    
                }
            }
            
            HStack {
                if #available(iOS 16.0, *) {
                    TextField("Enter a Text", text: $newNote, axis: .vertical)
                        .multilineTextAlignment(.center)
                        .frame(height: dim.height*0.08, alignment: .center)
                        .padding()
                        .background(.orange)
                        .cornerRadius(7)
                        .foregroundColor(.white)
                } else {
                    TextField("Enter a Text", text: $newNote)
                        .frame(height: dim.height*0.08, alignment: .center)
                        .padding()
                        .background(.orange)
                        .cornerRadius(7)
                        .foregroundColor(.white)
                }
                    
                Button (action: {
                    notes.append(text: newNote)
                    newNote = ""
                }) {
                    Label("", systemImage: "plus.circle.fill").font(.system(size: dim.width*0.12)).foregroundColor(.orange)
                }.shadow(radius: 2).padding(.leading)
            }.padding(.leading).padding(.trailing)
        }.padding(.top)
        
        
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
