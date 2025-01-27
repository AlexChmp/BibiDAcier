import SwiftUI

struct OnboardingView: View {
    let onboardingItems = [
        OnboardingItem(imageName: "onboarding4", title: "Bienvenue", description: "Découvrez notre application."),
        OnboardingItem(imageName: "onboarding5", title: "Fonctionnalités", description: "Accédez à des outils incroyables."),
        OnboardingItem(imageName: "onboarding6", title: "Commencez maintenant", description: "Inscrivez-vous et profitez-en !")
    ]
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @State private var currentPage = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<onboardingItems.count, id: \.self) { index in
                        ZStack {
                            // Image en plein écran
                            Image(onboardingItems[index].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                                .ignoresSafeArea()
                            
                            // Texte superposé en haut
                            VStack {
                                VStack(spacing: 10) {
                                    Text(onboardingItems[index].title)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .padding(.top, 40) // Ajuster l'espacement depuis le haut
                                    
                                    Text(onboardingItems[index].description)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 30)
                                }
                                .frame(maxWidth: .infinity)
                                .background(
                                    Color.white.opacity(0.7) // Ajouter un fond semi-transparent pour rendre le texte plus lisible
                                        .edgesIgnoringSafeArea(.top)
                                )
                                Spacer()
                            }
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                
                // Bouton Suivant / Commencer
                Button(action: {
                    if currentPage < onboardingItems.count - 1 {
                        currentPage += 1
                    } else {
                        hasSeenOnboarding = true
                    }
                }) {
                    Text(currentPage == onboardingItems.count - 1 ? "Commencer" : "Suivant")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, 20)
            }
        }
    }
}

// Modèle pour chaque écran d'onboarding
struct OnboardingItem {
    let imageName: String
    let title: String
    let description: String
}
