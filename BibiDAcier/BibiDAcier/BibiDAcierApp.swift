//
//  BibiDAcierApp.swift
//  BibiDAcier
//
//  Created by Alexandre on 10/01/2025.
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
struct BibiDAcierApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                MainTabView()
            } else {
                OnboardingView()
            }
        }
    }
}

