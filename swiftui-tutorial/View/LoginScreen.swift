//
//  LoginScreen.swift
//  swiftui-tutorial
//
//  Created by Abdulaziz Albahar on 10/1/22.
//

import SwiftUI

struct LoginScreen: View {
    //StateObject: used when the data needs to be stored inside of the view, so that when another view is redrawn, this object's data isn't reset, SAFER
    //ObservedObject: used when the data is stored outside of the view so when the view is redrawn, we won't lose the data
    @StateObject var userViewModel = UserViewModel()
    
    @State var email = ""
    @State var password = ""
    @State var textFieldFilled = false
    @State var isAuthenticatedAndSynced = false
    @State var errorOccurred = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Login").font(.system(size: 40, weight: .bold, design: .rounded)).padding(.bottom)
                
                Text("Email").fontWeight(.bold).foregroundColor(.gray).frame(width: 350, height: 20, alignment: .leading).padding(.leading).padding(.top).font(Font.system(size: 20))
                
                TextField("jsmith99@gmail.com" + "", text: $email).frame(width: 350, height: 50, alignment: .leading).padding(.leading).font(.system(size: 18, design: .rounded)).disableAutocorrection(true).autocapitalization(.none)
                
                Divider().padding(.leading).padding(.trailing)
                
                Text("Password").fontWeight(.bold).foregroundColor(.gray).frame(width: 350, height: 20, alignment: .leading).padding(.leading).padding(.top).font(Font.system(size: 20))
                
                SecureField("must contain 8+ characters", text: $password).frame(width: 350, height: 50, alignment: .leading).padding(.leading).font(.system(size: 18, design: .rounded)).disableAutocorrection(true).autocapitalization(.none)
                
                Divider().padding(.leading).padding(.trailing)
                
                NavigationLink(destination: NotesPage(), isActive: $isAuthenticatedAndSynced) {
                    EmptyView()
                }
                
                Button(action: {
                    // do all backend stuff
                    DispatchQueue.main.sync {
                        userViewModel.signIn(email: email, password: password) { noError in
                            errorOccurred = !noError
                        }
                    }
                    
                    isAuthenticatedAndSynced = userViewModel.userIsAuthenticatedAndSynced
                }) {
                    
                    if (userViewModel.isAuthenticating) {
                        ProgressView()
                    } else {
                        Label("Proceed", systemImage: "chevron.right.circle.fill").font(.system(size: 23))
                    }
                    
                    
                }.padding(.init(top: 50, leading: 0, bottom: 0, trailing: 0))
                    .disabled(textFieldFilled).disabled(userViewModel.isAuthenticating)
                    .alert("Some error occurred.", isPresented: $errorOccurred) {
                        Button("Ok", role: .cancel, action: {}) 
                    }
                
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
