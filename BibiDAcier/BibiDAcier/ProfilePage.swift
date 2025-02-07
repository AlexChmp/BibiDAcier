import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseFirestore
import PhotosUI

struct ProfilePage: View {
    @State private var nom: String = ""
    @State private var prenom: String = ""
    @State private var age: String = ""
    @State private var poids: String = ""
    @State private var taille: String = ""
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    @State private var isLoading: Bool = true // Indicateur de chargement pour afficher un loader si nécessaire
    
    // Instance de UserService pour envoyer les données à Firestore
    var userService = UserService()

    let verticalPaddingForForm: CGFloat = 20
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    // Avatar
                    if let avatarImage = avatarImage {
                        avatarImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 130.0, height: 130.0)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 130.0, height: 130.0)
                    }

                    PhotosPicker("Ajouter une image", selection: $avatarItem, matching: .images)
                        .onChange(of: avatarItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    avatarImage = Image(uiImage: uiImage)
                                } else {
                                    print("Impossible de charger l'image.")
                                }
                            }
                        }
                        .padding(.top, 10)
                    
                    VStack(spacing: verticalPaddingForForm) {
                        Group {
                            TextField("Nom", text: $nom)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                            
                            TextField("Prénom", text: $prenom)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                            
                            TextField("Âge", text: $age)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                            
                            TextField("Poids (kg)", text: $poids)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                            
                            TextField("Taille (cm)", text: $taille)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top, 20)
                    
                    // Bouton pour envoyer les données
                    Button(action: {
                        // Valider et envoyer les données à Firebase
                        saveUserData()
                    }) {
                        Text("Enregistrer le profil")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }
                .navigationTitle("Profil")
                .onAppear {
                    loadUserData()
                }
            }
        }
    }

    // Fonction pour récupérer les données de l'utilisateur depuis Firestore
    func loadUserData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Utilisateur non connecté.")
            return
        }
        
        // Appel à UserService pour récupérer les données
        userService.getUser(userId: userId) { user, error in
            isLoading = false // Stop le loader lorsque les données sont récupérées
            
            if let error = error {
                print("Erreur lors du chargement des données utilisateur: \(error.localizedDescription)")
                return
            }
            
            if let user = user {
                // Mettre à jour les champs avec les données récupérées
                nom = user.name
                prenom = user.firsName
                age = String(user.age)
                poids = String(user.weight)
                taille = String(user.height)
                // Ici tu pourrais aussi télécharger l'image du profil si tu as un lien vers l'image
                // Par exemple si `user.profilePicture` est une URL, tu pourrais charger l'image ici.
            }
        }
    }

    // Fonction pour envoyer les données à Firestore
    func saveUserData() {
        // Valider les entrées
        guard let ageInt = Int(age),
              let poidsDouble = Double(poids),
              let tailleInt = Int(taille),
              !nom.isEmpty, !prenom.isEmpty else {
            print("Veuillez vérifier les données saisies.")
            return
        }

        // Créer un objet User avec les données saisies
        let user = User(
            name: nom,
            firsName: prenom,
            age: ageInt,
            height: tailleInt,
            profilePicture: "url_de_l_image", // Ajouter une logique pour l'image si nécessaire
            weight: Int(poidsDouble)
        )
        
        // Utiliser UserService pour envoyer les données à Firestore
        userService.addUser(user: user) { error in
            if let error = error {
                print("Erreur lors de l'envoi des données: \(error.localizedDescription)")
            } else {
                print("Profil enregistré avec succès.")
            }
        }
    }
}


#Preview {
    ProfilePage()
}
