import SwiftUI
import FirebaseAuth
import FirebaseCore

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

