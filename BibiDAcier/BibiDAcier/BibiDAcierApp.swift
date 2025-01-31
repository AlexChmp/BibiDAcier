import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseAuth
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

    var body: some View {
        VStack {
            if isUserLoggedIn {
                // Si l'utilisateur est connecté, afficher la vue principale
                MainTabView()
//                TestSendData()
            } else {
                // Sinon, afficher la vue de connexion
                PhoneNumberView(onLoginSuccess: {
                    // Lors d'une connexion réussie, on met à jour l'état de la connexion
                    isUserLoggedIn = true
                })
            }
        }
        .onAppear {
            checkIfUserIsLoggedIn()
        }
    }

    func checkIfUserIsLoggedIn() {
        // Vérifie si l'utilisateur est déjà connecté avec Firebase
        if Auth.auth().currentUser != nil {
            isUserLoggedIn = true
        }
    }
}


//
//  TestSendData.swift
//  BibiDAcier
//
//  Created by neoxia on 31/01/2025.
//


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
    
    // Fonction pour ajouter un utilisateur à Firestore
    func addUser(user: User, completion: @escaping (Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "Utilisateur non connecté"]))
            return
        }
        
        do {
            let userData = try JSONEncoder().encode(user)
            let dictionary = try JSONSerialization.jsonObject(with: userData, options: .fragmentsAllowed) as? [String: Any]
            
            db.collection("users").document(userId).setData(dictionary ?? [:]) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }

    // Fonction pour récupérer un utilisateur depuis Firestore
    func getUser(userId: String, completion: @escaping (User?, Error?) -> Void) {
        db.collection("users").document(userId).getDocument { document, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let document = document, document.exists else {
                completion(nil, NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Utilisateur non trouvé"]))
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
    
    // Fonction pour décoder les données de Firestore en un objet User
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




//struct TestSendData: View{
//    var userService = UserService()
//    let user = User(name: "Alexandre", firsName: "Champier", age: 14, height: 190, profilePicture: "", weight: 1000)
//
//    var body: some View {
//        Button("send Data", action: {
//            userService.addUser(user: user, completion: {_ in })
//        })
//    }
//}
