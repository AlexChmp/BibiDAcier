

import SwiftUI

struct OnboardingView: View {
    let onboardingItems = [
        OnboardingItem(imageName: "onboarding1", title: "Bienvenue", description: "Découvrez notre application."),
        OnboardingItem(imageName: "onboarding2", title: "Fonctionnalités", description: "Accédez à des outils incroyables."),
        OnboardingItem(imageName: "onboarding3", title: "Commencez maintenant", description: "Inscrivez-vous et profitez-en !")
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
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                                .ignoresSafeArea()
                            
                            VStack {
                                Spacer()
                                
                                // Texte superposé à l'image
                                Text(onboardingItems[index].title)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(currentPage == 0 ? .black : .white)
                                    .shadow(color: currentPage == 0 ? .clear : .black, radius: 5)
                                    .padding(.bottom, 10)
                                
                                Text(onboardingItems[index].description)
                                    .font(.body)
                                    .foregroundColor(currentPage == 0 ? .black : .white)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 30)
                                    .shadow(color: currentPage == 0 ? .clear : .black, radius: 5) 
                                
                                Spacer()
                                    .frame(height: geometry.size.height * 0.1)
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

struct OnboardingPageView: View {
    let item: OnboardingItem

    var body: some View {
        EmptyView()
    }
}

// Modèle pour chaque écran d'onboarding
struct OnboardingItem {
    let imageName: String
    let title: String
    let description: String
}

