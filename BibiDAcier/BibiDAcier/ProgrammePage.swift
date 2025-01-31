import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ProgrammePage: View {
    @State private var isClickedInfo: Bool = false
    @State private var programmes: [(name: String, exercises: [String])] = []
    @State private var showDeleteConfirmation: Bool = false
    @State private var programmeToDelete: (name: String, exercises: [String])?
    
    let programmeService = ProgrammeService()
    
    var body: some View {
        NavigationView {
            if isClickedInfo {
                VStack {
                    Text("Dans cet onglet, vous pouvez sélectionner des exercices et créer votre programme d'entrainement")
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: {
                        isClickedInfo = false
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
                VStack {
                    Text("Programmes Enregistrés")
                        .font(.title)
                        .bold()
                        .padding()

                    if programmes.isEmpty {
                        Text("Aucun programme enregistré")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding()
                    } else {
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
        .onAppear {
            loadProgrammes() // Charger les programmes depuis Firestore à l'apparition de la page
        }
    }

    private func loadProgrammes() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        programmeService.db.collection("users")
            .document(userId)
            .collection("programmes")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Erreur lors du chargement des programmes: \(error.localizedDescription)")
                    return
                }
                
                if let snapshot = snapshot {
                    programmes = snapshot.documents.compactMap { doc -> (name: String, exercises: [String])? in
                        let data = doc.data()
                        guard let name = data["name"] as? String,
                              let exercises = data["exercises"] as? [String] else { return nil }
                        return (name: name, exercises: exercises)
                    }
                }
            }
    }

    private func deleteProgramme(_ programme: (name: String, exercises: [String])) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        if let index = programmes.firstIndex(where: { $0.name == programme.name && $0.exercises == programme.exercises }) {
            programmes.remove(at: index)
            
            // Suppression du programme dans Firestore
            programmeService.db.collection("users")
                .document(userId)
                .collection("programmes")
                .whereField("name", isEqualTo: programme.name)
                .getDocuments { snapshot, error in
                    if let snapshot = snapshot, !snapshot.isEmpty {
                        snapshot.documents.first?.reference.delete()
                    }
                }
        }
    }
}
