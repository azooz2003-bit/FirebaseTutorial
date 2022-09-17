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
                
            }
            
            HStack {
                TextField("Enter a Text", text: $newNote).frame(height: dim.height*0.08, alignment: .center).padding(.leading).background(.orange).cornerRadius(7).shadow(radius: 5)
                Button (action: {
                    notes.append(text: newNote)
                }) {
                    Label("", systemImage: "plus.circle.fill").font(.system(size: dim.width*0.12)).foregroundColor(.orange)
                }.shadow(radius: 2).padding(.leading)
            }.padding(.leading).padding(.trailing)
        }
        
        
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
