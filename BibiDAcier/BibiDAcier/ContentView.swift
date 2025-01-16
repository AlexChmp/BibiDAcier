import SwiftUI

struct ContentView: View {
    @State private var selectedIndex: Int = 0

    // Exemple de liste d'exercices
    let exercises_arrière_épaule = [
        "Tirage corde",
        "Élévations latérales"
    ]
    let exercise_arrière_épaule: [String: String] = [
        "Tirage corde": "Le tirage corde est un excellent exercice pour cibler les muscles postérieurs des épaules.",
        "Élévations latérales": "Les élévations latérales renforcent la partie externe de l'épaule et améliorent la stabilité."
    ]

    let exercises_épaules = [
        "Élévation latérales poids libres/ poulie",
        "Press épaule",
        "Développé militaire banc"
    ]
    let exercise_épaule: [String: String] = [
        "Élévation latérales poids libres/ poulie": "super exo.",
        "Press épaule": "super exo",
        "Développé militaire banc": "super exo"
    ]
    
    let exercises_pectoraux = [
        "Développé couché barre",
        "Développé couché haltères",
        "Convergente",
        "Pec Fly"
    ]
    let exercise_pectoraux: [String: String] = [
        "Développé couché barre": "super exo",
        "Développé couché haltères": "super exo",
        "Convergente": "super exo",
        "Pec Fly": "super exo"
    ]
    

    
    var body: some View {
        TabView(selection: $selectedIndex) {
            // Onglet Exercices
            NavigationStack {
                ScrollView { // Intégration de la ScrollView
                    
                    VStack(alignment: .leading, spacing: 20) {
                       
                        HStack{
                            Text("Haut du corps")
                                .bold()
                                .font(.largeTitle)
                                .frame(maxWidth: .infinity) // Centrer le texte
                                .multilineTextAlignment(.center)
                                .padding(.top)
                        }
                        
                        HStack {
                            Image("arrièred'épaules_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 200) // Taille de l'image
                        }
                        .frame(maxWidth: .infinity) // Centrer l'image
                        
                        HStack {
                            Text("Arrières d'épaule")
                                .font(.headline)
                                .frame(maxWidth: .infinity) // Centrer le texte
                                .multilineTextAlignment(.center)
                        }
                        
                        List(exercises_arrière_épaule, id: \.self) { exercise in
                            NavigationLink(
                                destination: ExerciseDetailView(
                                    exerciseName: exercise,
                                    exerciseDetail: exercise_arrière_épaule[exercise] ?? "Aucune information disponible"
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

                        // Section Épaules
                        HStack {
                            Image("épaules_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 200) // Taille de l'image
                        }
                        .frame(maxWidth: .infinity) // Centrer l'image
                        
                        HStack {
                            Text("Épaules")
                                .font(.headline)
                                .frame(maxWidth: .infinity) // Centrer le texte
                                .multilineTextAlignment(.center)
                        }
                        
                        List(exercises_épaules, id: \.self) { exercise in
                            NavigationLink(
                                destination: ExerciseDetailView(
                                    exerciseName: exercise,
                                    exerciseDetail: exercise_épaule[exercise] ?? "Aucune information disponible"
                                )
                            ) {
                                HStack {
                                    Text(exercise)
                                        .font(.title3)
                                }
                                .padding(.vertical, 5)
                            }
                        }
                        .frame(height: 150)
                        
                        HStack {
                            Image("pectoraux_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 200) // Taille de l'image
                        }
                        .frame(maxWidth: .infinity) // Centrer l'image
                        
                        HStack {
                            Text("Pectoraux")
                                .font(.headline)
                                .frame(maxWidth: .infinity) // Centrer le texte
                                .multilineTextAlignment(.center)
                        }
                        
                        List(exercises_pectoraux, id: \.self) { exercise in
                            NavigationLink(
                                destination: ExerciseDetailView(
                                    exerciseName: exercise,
                                    exerciseDetail: exercise_pectoraux[exercise] ?? "Aucune information disponible"
                                )
                            ) {
                                HStack {
                                    Text(exercise)
                                        .font(.title3)
                                }
                                .padding(.vertical, 5)
                            }
                        }
                        .frame(height: 150)
                        
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

struct ExerciseDetailView: View {
    var exerciseName: String
    var exerciseDetail: String
    
    var body: some View {
        VStack {
            // Afficher les informations supplémentaires
            Text(exerciseDetail)
                .font(.body)
                .padding()
                .multilineTextAlignment(.center) // Centrer le texte des détails de l'exercice
        }
        .navigationTitle(exerciseName)
    }
}
