//
//  ContentView.swift
//  swiftui-tutorial
//
//  Created by Nicolas Rios on 9/17/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    TextField("Enter a Text", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/).background(.red)
                }
            }.border(.black)
            
            Button (action: {
                
            }) {
                Label("", systemImage: "plus.circle.fill")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
