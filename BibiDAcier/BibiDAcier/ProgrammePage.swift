import SwiftUI

// Première page affichant les programmes enregistrés
struct ProgrammePage: View {
    @State private var isClickedInfo: Bool = false // État pour afficher ou masquer la vue d'information
    @State private var programmes: [(name: String, exercises: [String])] = [] // Liste des programmes enregistrés
    @State private var showDeleteConfirmation: Bool = false // État pour afficher l'alerte de confirmation
    @State private var programmeToDelete: (name: String, exercises: [String])? // Programme à supprimer
    
    var body: some View {
        NavigationView {
            if isClickedInfo {
                // Affiche uniquement le message d'information
                VStack {
                    Text("Dans cet onglet, vous pouvez sélectionner des exercices et créer votre programme d'entrainement")
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: {
                        isClickedInfo = false // Retour à la vue principale
                    }) {
                        Text("Retour")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
            } else {
                // Vue principale avec la liste des programmes enregistrés
                VStack {
                    Text("Programmes Enregistrés")
                        .font(.title)
                        .bold()
                        .padding()

                    // Vérifier si des programmes existent
                    if programmes.isEmpty {
                        Text("Aucun programme enregistré")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        // Liste des programmes enregistrés
                        List {
                            ForEach(programmes.indices, id: \.self) { index in
                                let programme = programmes[index]
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(programme.name)
                                            .font(.headline)
                                        Text("Exercices: \(programme.exercises.joined(separator: ", "))")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    // Bouton corbeille pour supprimer le programme
                                    Button(action: {
                                        programmeToDelete = programme
                                        showDeleteConfirmation = true
                                    }) {
                                        Image(systemName: "trash.fill")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(.red)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .padding(.leading, 10)
                                    .frame(width: 30, height: 30)
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }

                    NavigationLink(destination: NewProgrammePage(programmes: $programmes)) {
                        VStack {
                            HStack {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Nouveau Programme")
                                    .bold()
                            }
                            .foregroundColor(.blue)
                            .padding()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }

                    Spacer()
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isClickedInfo.toggle()
                        }) {
                            Image(systemName: "info.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
        .navigationTitle("Programmes")
        .alert(isPresented: $showDeleteConfirmation) {
            Alert(
                title: Text("Êtes-vous sûr ?"),
                message: Text("Vous êtes sur le point de supprimer le programme '\(programmeToDelete?.name ?? "")'. Cette action est irréversible."),
                primaryButton: .destructive(Text("Supprimer")) {
                    if let programmeToDelete = programmeToDelete {
                        deleteProgramme(programmeToDelete)
                    }
                },
                secondaryButton: .cancel {
                }
            )
        }
    }
    
    private func deleteProgramme(_ programme: (name: String, exercises: [String])) {
        if let index = programmes.firstIndex(where: { $0.name == programme.name && $0.exercises == programme.exercises }) {
            programmes.remove(at: index)
        }
    }
}
