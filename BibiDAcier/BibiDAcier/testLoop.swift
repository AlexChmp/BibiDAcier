import SwiftUI
struct testLoop: View {
    @State private var selectedIndex: Int = 0
    var body: some View {
        TabView(selection: $selectedIndex) {
            // Onglet Exercices
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Boucle sur les groupes musculaires
                        ForEach(muscleGroups, id: \.name) { group in
                            SectionView(muscleGroup: group)
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("Exercices")
            }
            .tabItem {
                Text("Exercices")
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
// Vue pour une section spécifique (groupe musculaire)
struct SectionView: View {
    let muscleGroup: MuscleGroup
    var body: some View {
        VStack {
            // Image du groupe musculaire
            HStack {
                Image(muscleGroup.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
            }
            .frame(maxWidth: .infinity)
            // Titre du groupe musculaire
            HStack {
                Text(muscleGroup.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            }
            // Liste des exercices
            List(muscleGroup.exercises, id: \.self) { exercise in
                NavigationLink(
                    destination: ExerciseDetailView(
                        exerciseName: exercise,
                        exerciseDetail: muscleGroup.exerciseDetails[exercise] ?? "Aucune information disponible"
                    )
                ) {
                    HStack {
                        Text(exercise)
                            .font(.title3)
                    }
                    .padding(.vertical, 5)
                }
            }
            .frame(height: 150) // Limiter la hauteur de la liste
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        testLoop()
    }
}
