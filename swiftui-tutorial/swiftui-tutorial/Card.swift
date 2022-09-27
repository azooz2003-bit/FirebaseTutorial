//
//  Card.swift
//  swiftui-tutorial
//
//  Created by Amit Kulkarni on 9/18/22.
//

import SwiftUI

struct Card: View {
    var textToDisplay : String = ""
    //let dim = UIScreen.main.bounds
    
    init(text: String) {
        self.textToDisplay = text
    }
    
    var body: some View {
        Text(textToDisplay)
            .frame(width: 300, alignment: .center)
            .padding()
            .background(.yellow)
            .cornerRadius(7)
            .foregroundColor(.white)
            
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(text: "a")
    }
}
