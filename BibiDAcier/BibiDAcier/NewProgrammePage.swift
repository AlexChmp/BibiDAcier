import SwiftUI

struct NewProgrammePage: View {
    @Binding var programmes: [(name: String, exercises: [String])] // Binding pour les programmes
    @State private var selectedExercises: [String] = []
    @State private var programmeName: String = "" // Le nom du programme que l'utilisateur va entrer
    @State private var isSaving: Bool = false // Un état pour afficher un indicateur de sauvegarde
    
    @Environment(\.presentationMode) var presentationMode // Permet de fermer la vue et revenir à la vue précédente

    var body: some View {
        VStack {
            Text("Sélectionnez vos exercices")
                .font(.title)
                .bold()
                .padding()

            // Liste des exercices
            List {
                ForEach(muscleGroups, id: \.name) { group in
                    Section(header: Text(group.name).font(.headline)) {
                        ForEach(group.exercises, id: \.self) { exercise in
                            HStack {
                                Text(exercise) // Nom de l'exercice
                                Spacer()
                                Button(action: {
                                    toggleSelection(of: exercise)
                                }) {
                                    Image(systemName: selectedExercises.contains(exercise) ? "checkmark.circle.fill" : "circle")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(selectedExercises.contains(exercise) ? .green : .blue)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            
            // Champ de texte pour entrer le nom du programme
            TextField("Entrez le nom du programme", text: $programmeName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .font(.system(size: 18, weight: .bold)) // Texte en gras
                .foregroundColor(.black) // Texte en noir
                .shadow(color: .blue, radius: 2, x: 0, y: 0) // Effet de brillance léger


            // Bouton pour valider la sélection
            Button(action: {
                if selectedExercises.isEmpty || programmeName.isEmpty {
                    // Vérifier que des exercices sont sélectionnés et un nom est donné
                    return
                }
                
                // Enregistrer le programme avec le nom et les exercices sélectionnés
                saveProgramme()
                
                // Revenir à la première page après l'enregistrement
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Valider la sélection")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .padding(.top, 10)
        }
        .navigationTitle("Nouveau Programme")
        .padding()
    }

    // Fonction pour gérer la sélection
    private func toggleSelection(of exercise: String) {
        if selectedExercises.contains(exercise) {
            selectedExercises.removeAll { $0 == exercise }
        } else {
            selectedExercises.append(exercise)
        }
    }
    
    // Fonction pour enregistrer le programme
    private func saveProgramme() {
        let newProgramme = (name: programmeName, exercises: selectedExercises)
        programmes.append(newProgramme) // Ajouter le programme à la liste
        
        // Réinitialiser les champs après sauvegarde
        programmeName = ""
        selectedExercises.removeAll()
    }
}
