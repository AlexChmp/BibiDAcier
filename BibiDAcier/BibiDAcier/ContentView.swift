import SwiftUI

struct ContentView: View {
    @State private var selectedIndex: Int = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            // Onglet Exercices
            NavigationStack {
                Text("Exercices")
                    .navigationTitle("Listes exercices")
            }
            .tabItem {
                Text("Exercices")
                // Change l'image en fonction de l'onglet sélectionné
                Image(selectedIndex == 0 ? "list_icon_selected" : "list_icon_unselected")

            }
            .tag(0)
            
            // Onglet Timer
            NavigationStack {
                Text("Timer")
                    .navigationTitle("Timer")
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
