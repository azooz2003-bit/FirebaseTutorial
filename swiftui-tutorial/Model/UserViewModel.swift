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
        user != nil && userIsAuthenticated
    }
    
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) { //ADD CLOSURE
        isAuthenticating = true
        
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            // these variables are retrieved from Firebase for what we call the "completion", we will use them to set the closures, and handle error appropriately. Weak self is stated to allow instances to be released, like in the case of the result and error instances, and prevent an endless memory cycle.
            guard result != nil, error == nil else { // "used to transfer program control out of scope when certain conditions are not met", in this case to exit the function
                completion(false)
                return
            }
            // guard is rly simple, the exact opposite of an if statement. It essentially says "if not ___". In this case if result is == to nil, meaning the boolean is false, it would execute the empty return. Otherwise, it would move on to the code after.
            DispatchQueue.main.async {
                self?.sync()
            } // we used "async" to ensure that we're not blocking the code after it from running, so that we can perform two tasks simultaneously, FYI: this can slow performance, and can lead to the "race condition": when an app is dependent on order of code execution.
        }
        
        isAuthenticating = false
        completion(true)

    }
    
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
        isAuthenticating = true

        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            DispatchQueue.main.async {
                self?.add(User(uuid: (self?.uuid)!))
                self?.sync()
            }
            
        }
        
        isAuthenticating = false
        completion(true)

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
    
    private func sync() {
        guard userIsAuthenticated else { return }
        db.collection("users").document(self.uuid!).getDocument { (document, error) in
            guard document != nil, error == nil else { return } // allows us to perform an early exit from the function like this
            do {
                try self.user = document!.data(as: User.self)
            } catch {
                print("Sync error: \(error)")
            }
        }
    }
    
    func add(_ user: User) { // _ represents an unnamed parameter in swift, but here we're omitting the argument label by adding _. So that we can just use add(someUser) instead of add(user: someUser)
        guard userIsAuthenticated else { return }
        do {
            let _ = try db.collection("users").document(self.uuid!).setData(from: user) // firestore is smart enough to do all the formatting for us, that's why we're passing in a custom User object
            // in this case we're using _ to represent an unnamed variable, or one we don't care about naming
        } catch {
            print("Error adding")
        }
    }
    
    /**
    func update() {
        guard userIsAuthenticatedAndSynced else { return } // to ensure we have pulled the data from the database
        do {
            let _ = try db.collection("users").document(self.uuid!).setData(from: user)
        } catch {
            print("error updating")
        }
    }
     */
}
