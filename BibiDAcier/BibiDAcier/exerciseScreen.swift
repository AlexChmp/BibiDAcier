import SwiftUI

struct ExerciseScreen: View {
    var body: some View {
        ExerciseScreenContent()
    }
}

// Contenu spécifique aux exercices
struct ExerciseScreenContent: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Boucle sur les groupes musculaires
                ForEach(muscleGroups, id: \.name) { group in
                    SectionView(muscleGroup: group)
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Exercices")
    }
}

// Vue pour une section spécifique (groupe musculaire)
struct SectionView: View {
    let muscleGroup: MuscleGroup
    var body: some View {
        VStack {
            // Image du groupe musculaire
            HStack {
                Image(muscleGroup.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
            }
            .frame(maxWidth: .infinity)
            // Titre du groupe musculaire
            HStack {
                Text(muscleGroup.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            }
            // Liste des exercices
            List(muscleGroup.exercises, id: \.self) { exercise in
                NavigationLink(
                    destination: ExerciseDetailView(
                        exerciseName: exercise,
                        exerciseDetail: muscleGroup.exerciseDetails[exercise] ?? "Aucune information disponible"
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
        }
    }
}

struct ExerciseDetailView: View{
    let exerciseName: String
    let exerciseDetail: String
    
    var body: some View{
        VStack{
            Text(exerciseName)
            Text(exerciseDetail)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseScreen()
    }
}
