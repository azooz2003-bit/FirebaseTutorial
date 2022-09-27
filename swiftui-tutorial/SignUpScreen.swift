//
//  SignUp.swift
//  swiftui-tutorial
//
//  Created by Abdulaziz Albahar on 9/27/22.
//

import SwiftUI

struct SignUpScreen: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Sign-up").font(.system(size: 40, weight: .bold, design: .rounded)).padding(.bottom)
                Text("Email").fontWeight(.bold).foregroundColor(.gray).frame(width: 350, height: 20, alignment: .leading).padding(.leading).padding(.top).font(Font.system(size: 20))
                
                TextField("jsmith99@gmail.com" + "", text: $email).frame(width: 350, height: 50, alignment: .leading).padding(.leading).font(.system(size: 18, design: .rounded)).disableAutocorrection(true).autocapitalization(.none)
                
                Divider().padding(.leading).padding(.trailing)
                
                Text("Password").fontWeight(.bold).foregroundColor(.gray).frame(width: 350, height: 20, alignment: .leading).padding(.leading).padding(.top).font(Font.system(size: 20))
                
                SecureField("must contain 8+ characters", text: $password).frame(width: 350, height: 50, alignment: .leading).padding(.leading).font(.system(size: 18, design: .rounded)).disableAutocorrection(true).autocapitalization(.none)
                
                Divider().padding(.leading).padding(.trailing)
                
                Button(action: {
                    
                }) {
                    Label("Proceed", systemImage: "chevron.right.circle.fill").font(.system(size: 23))
                }.padding(.init(top: 50, leading: 0, bottom: 0, trailing: 0))
            }
        }
        
        
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
