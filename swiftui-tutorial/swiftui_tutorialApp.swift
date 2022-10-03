//
//  swiftui_tutorialApp.swift
//  swiftui-tutorial
//
//  Created by Nicolas Rios on 9/17/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct swiftui_tutorialApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                let user = UserViewModel()
                if (user.userIsAuthenticatedAndSynced) {
                    NotesPage().environmentObject(user)
                } else {
                    LoginScreen()
                }
            }
            
        }
    }
}
