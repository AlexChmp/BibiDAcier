import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import Foundation

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Auth.auth().setAPNSToken(deviceToken, type: .sandbox)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(userInfo) {
            completionHandler(.noData)
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if Auth.auth().canHandle(url) {
            return true
        }
        return false
    }
}

// Main
@main
struct BibiDAcierApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @State private var isUserLoggedIn = false

    var body: some Scene {
        WindowGroup {
            AuthCheckView(isUserLoggedIn: $isUserLoggedIn)
        }
    }
}

struct AuthCheckView: View {
    @Binding var isUserLoggedIn: Bool
    @State private var isUserNew = false
    @State private var isNavigatingToMain = false  // Ajouté pour contrôler la navigation vers la vue principale

    var body: some View {
        VStack {
            if isUserLoggedIn {
                if isUserNew {
                    // Si l'utilisateur est nouveau, afficher l'écran de création de profil
                    ProfileSetupView(onProfileCreated: {
                        isUserLoggedIn = true  // Marquer comme connecté après la création du profil
                        isUserNew = false  // L'utilisateur n'est plus nouveau après la création du profil
                        isNavigatingToMain = true  // Rediriger vers l'écran principal
                    })
                } else {
                    // Si l'utilisateur est connecté et que son profil est configuré, afficher la vue principale
                    MainTabView()
                }
            } else {
                // Sinon, afficher la vue de connexion
                PhoneNumberView(onLoginSuccess: {
                    isUserLoggedIn = true
                    checkIfUserExists()  // Vérifie si l'utilisateur existe dans Firestore
                })
            }
        }
        .onAppear {
            checkIfUserIsLoggedIn()  // Vérifie si l'utilisateur est déjà connecté
        }
        .fullScreenCover(isPresented: $isNavigatingToMain) {
            // Lorsque l'utilisateur est nouveau et a créé son profil, navigue vers MainTabView
            MainTabView()
        }
    }

    func checkIfUserIsLoggedIn() {
        // Vérifie si l'utilisateur est déjà connecté avec Firebase
        if Auth.auth().currentUser != nil {
            isUserLoggedIn = true
            checkIfUserExists()  // Vérifie si l'utilisateur existe déjà dans Firestore
        }
    }
    
    func checkIfUserExists() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        // Vérifie si l'utilisateur existe déjà dans Firestore
        let userService = UserService()
        userService.getUser(userId: userId) { user, error in
            if let error = error {
                print("Erreur lors de la récupération de l'utilisateur: \(error.localizedDescription)")
                return
            }
            
            if user != nil {
                // Si l'utilisateur existe, on continue à afficher la vue principale
                isUserNew = false
            } else {
                // Si l'utilisateur n'existe pas, on le marque comme nouveau
                isUserNew = true
            }
        }
    }
}


struct ProfileSetupView: View {
    @State private var name = ""
    @State private var firstName = ""
    @State private var ageString = ""  // Utilise une string temporaire pour l'âge
    @State private var heightString = ""  // Utilise une string temporaire pour la taille
    @State private var weightString = ""  // Utilise une string temporaire pour le poids
    @State private var profilePicture = "" // À implémenter si tu veux ajouter une photo
    
    var onProfileCreated: () -> Void  // Callback pour indiquer que le profil a été créé
    
    var body: some View {
        VStack {
            Text("Bienvenue dans Bibi d'acier ! Complétez votre profil")
                .font(.title2)
                .padding()
            
            TextField("Nom", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Prénom", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Age field (with placeholder and conversion to Int)
            TextField("Âge", text: $ageString)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Height field (with placeholder and conversion to Int)
            TextField("Taille (cm)", text: $heightString)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Weight field (with placeholder and conversion to Int)
            TextField("Poids (kg)", text: $weightString)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Sauvegarder") {
                // Convert les chaînes de caractères en entiers
                guard let age = Int(ageString), let height = Int(heightString), let weight = Int(weightString) else {
                    // Afficher une alerte ou une erreur si les conversions échouent
                    print("Erreur : Les valeurs d'âge, taille et poids doivent être des entiers valides.")
                    return
                }
                
                // Crée l'objet User avec les valeurs
                let newUser = User(name: name, firsName: firstName, age: age, height: height, profilePicture: profilePicture, weight: weight)
                saveUser(newUser)
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    func saveUser(_ user: User) {
        // Appeler le service pour sauvegarder l'utilisateur dans Firestore
        let userService = UserService()
        userService.addUser(user: user) { error in
            if let error = error {
                print("Erreur lors de la sauvegarde du profil: \(error.localizedDescription)")
                return
            }
            print("Profil créé avec succès !")
            onProfileCreated()  // Informe l'écran parent que le profil est créé
        }
    }
}






struct User: Codable {
    var name: String
    var firsName: String
    var age: Int
    var height: Int
    var profilePicture: String
    var weight: Int
}


class UserService {
    let db = Firestore.firestore()
    
    func addUser(user: User, completion: @escaping (Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "Utilisateur non connecté"]))
            return
        }
        
        do {
            let userData = try JSONEncoder().encode(user)
            let jsonObject = try JSONSerialization.jsonObject(with: userData, options: .fragmentsAllowed)
            
            // Vérifie que le jsonObject est bien un dictionnaire [String: Any]
            guard let dictionary = jsonObject as? [String: Any] else {
                completion(NSError(domain: "Serialization", code: 500, userInfo: [NSLocalizedDescriptionKey: "Données utilisateur invalides"]))
                return
            }
            
            db.collection("users").document(userId).setData(dictionary) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }


    func getUser(userId: String, completion: @escaping (User?, Error?) -> Void) {
        db.collection("users").document(userId).getDocument { document, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let document = document, document.exists else {
                completion(nil, nil)  // Utilisateur non trouvé
                return
            }
            
            let data = document.data()
            
            if let data = data {
                do {
                    let user = try self.decodeUser(data)
                    completion(user, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Aucune donnée disponible"]))
            }
        }
    }
    
    private func decodeUser(_ data: [String: Any]) throws -> User {
        guard let name = data["name"] as? String,
              let firsName = data["firsName"] as? String,
              let age = data["age"] as? Int,
              let height = data["height"] as? Int,
              let weight = data["weight"] as? Int,
              let profilePicture = data["profilePicture"] as? String else {
            throw NSError(domain: "Decoding", code: 500, userInfo: [NSLocalizedDescriptionKey: "Données utilisateur invalides"])
        }
        
        return User(name: name, firsName: firsName, age: age, height: height, profilePicture: profilePicture, weight: weight)
    }
}

