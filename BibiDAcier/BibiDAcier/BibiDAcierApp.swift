//
//  BibiDAcierApp.swift
//  BibiDAcier
//
//  Created by Alexandre on 10/01/2025.
//
import SwiftUI

@main
struct BibiDAcierApp: App {
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
