//
//  ContentView.swift
//  swiftui-tutorial
//
//  Created by Nicolas Rios on 9/17/22.
//

import SwiftUI

struct ContentView: View {
    let dim = UIScreen.main.bounds
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    TextField("Enter a Text", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/).background(.red)
                }
            }.border(.black)
            
            Button (action: {
                
            }) {
                Label("", systemImage: "plus.circle.fill").frame(width:dim.width * 0.3, height:dim.height * 0.3,  alignment: .center)
            }.frame(width:dim.width * 0.3, height:dim.height * 0.3, alignment: .center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
