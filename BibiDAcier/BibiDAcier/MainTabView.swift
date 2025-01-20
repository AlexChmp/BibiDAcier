//
//  TabView.swift
//  BibiDAcier
//
//  Created by neoxia on 20/01/2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            // Onglet Exercices
            NavigationStack {
                ExerciseScreen()
            }
            .tabItem {
                Text("Exercices")
                Image(selectedIndex == 0 ? "list_icon_selected" : "list_icon_unselected")
            }
            .tag(0)
            
            // Onglet Timer
            NavigationStack {
                TimerPage()
            }
            .tabItem {
                Text("Timer")
                Image(selectedIndex == 1 ? "timer_icon_selected" : "timer_icon_unselected")
            }
            .tag(1)
            
            // Onglet Programmes
            NavigationStack {
                Text("Programme")
                    .navigationTitle("Programme perso")
            }
            .tabItem {
                Text("Programmes")
                Image(selectedIndex == 2 ? "programme_icon_selected" : "programme_icon_unselected")
            }
            .tag(2)
            
            // Onglet Profil
            NavigationStack {
                Text("Profil")
                    .navigationTitle("Profil")
            }
            .tabItem {
                Text("Profil")
                Image(selectedIndex == 3 ? "profil_icon_selected" : "profil_icon_unselected")
            }
            .tag(3)
        }
    }
}
struct TimerScreen: View {
    var body: some View {
        Text("Timer")
            .navigationTitle("Timer")
    }
}

struct ProgrammesScreen: View {
    var body: some View {
        Text("Programme")
            .navigationTitle("Programme perso")
    }
}

struct ProfilScreen: View {
    var body: some View {
        Text("Profil")
            .navigationTitle("Profil")
    }
}


struct PreviewTest: PreviewProvider {
    static var previews: some View {
       MainTabView()
    }
}
