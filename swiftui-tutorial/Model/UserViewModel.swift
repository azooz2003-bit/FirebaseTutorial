//
//  UserViewModel.swift
//  swiftui-tutorial
//
//  Created by Abdulaziz Albahar on 10/1/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var user: User? // will be set to nil if there's no actual data in it
    @Published var isAuthenticating: Bool = false
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    var uuid: String? { // this is what we call computed properties, they only compute when we call on them
        auth.currentUser?.uid
    }
    var userIsAuthenticated: Bool {
        auth.currentUser != nil // if it equals nil then the user is not authenticated
    }
    var userIsAuthenticatedAndSynced: Bool { // here we check if it's both synced(user data has been retrieved from Firebase) and authenticated
        user != nil && userIsAuthenticated // IF USER OBJECT INITIALIZED AND AUTHENTICATED
    }
    
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) { //ADD CLOSURE
        signOut() { success in
            
        }
        isAuthenticating = true
        
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            // these variables are retrieved from Firebase for what we call the "completion", we will use them to set the closures, and handle error appropriately. Weak self is stated to allow instances to be released, like in the case of the result and error instances, and prevent an endless memory cycle.
            if result == nil || error != nil {
                self?.isAuthenticating = false
                completion(false)
                return
            } else {
                completion(true)
                print((self?.uuid)!)
                self?.sync()
                //print(self!.user)
                self?.isAuthenticating = false
            }
            
            // guard is rly simple, the exact opposite of an if statement. It essentially says "if not ___". In this case if result is == to nil, meaning the boolean is false, it would execute the empty return. Otherwise, it would move on to the code after.
            // we used "async" to ensure that we're not blocking the code after it from running, so that we can perform two tasks simultaneously, FYI: this can slow performance, and can lead to the "race condition": when an app is dependent on order of code execution.
        }
        
        

    }
    
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
        signOut() { success in
            
        }
        isAuthenticating = true
        
        
        self.auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            
            if error != nil {
                self!.isAuthenticating = false
                completion(false)
                return
            } else {
                completion(true)
                self?.add()
                //User(uuid: (self?.uuid)!,  notes: [])
                self?.sync()
                self?.isAuthenticating = false
            }
              
        }
        
    }
    
    func signOut(completion: @escaping (Bool) -> Void) {
        do {
            try auth.signOut()
            self.user = nil
            completion(true)
        } catch {
            // we can return a "closure" here to initiate an alert in the view that calls this function
            completion(false)
            print("Error signing out user")
        }
    }
    
    func sync() {
        if !userIsAuthenticated {
            print("pre-sync abort")
            return
        }
        db.collection("users").document(self.uuid!).getDocument { (document, error) in
            print(document!)
            if (document == nil || error != nil) {
                print("Error pre-sync")
                return
            }
            do {
                try self.user = document!.data(as: User.self)
                print(try document!.data(as: User.self))
                print(self.user)
            } catch {
                print("SYNC ERROR: \(error)")
            }
        }
    }
    
    func add() { // _ represents an unnamed parameter in swift, but here we're omitting the argument label by adding _. So that we can just use add(someUser) instead of add(user: someUser)
        if !userIsAuthenticated {
            print("pre-add abort")
            return
        }
        do {
            let _ = try db.collection("users").document(self.uuid!).setData(from: User(uuid: (self.uuid)!,  notes: (self.user?.notes) ?? [])) // firestore is smart enough to do all the formatting for us, that's why we're passing in a custom User object
            // in this case we're using _ to represent an unnamed variable, or one we don't care about naming
        } catch {
            print("Error adding")
        }
    }
    
    // NOT IMPORTANT
    func update() {
        if !userIsAuthenticatedAndSynced {
            return
        } // to ensure we have pulled the data from the database
        do {
            let _ = try db.collection("users").document(self.uuid!).setData(from: user)
        } catch {
            print("error updating")
        }
    }
    
}
