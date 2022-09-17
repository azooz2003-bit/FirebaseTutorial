//
//  Notes.swift
//  swiftui-tutorial
//
//  Created by Amit Kulkarni on 9/17/22.
//

import Foundation

class Notes {
    var text : String = ""
    var id : Int = 0
    
    init(text: String, id: Int) {
        self.text = text
        self.id = id
    }
}
