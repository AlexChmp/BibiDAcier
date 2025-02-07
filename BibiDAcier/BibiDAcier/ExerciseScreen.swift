import SwiftUI

struct ExerciseScreen: View {
    var body: some View {
        ExerciseScreenContent()
    }
}

struct ExerciseScreenContent: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(muscleGroups, id: \.name) { group in
                    SectionView(muscleGroup: group)
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Exercices")
    }
}

struct SectionView: View {
    let muscleGroup: MuscleGroup
    var body: some View {
        VStack {
            HStack {
                Image(muscleGroup.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
            }
            .frame(maxWidth: .infinity)
            
            HStack {
                Text(muscleGroup.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            }

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
            .frame(height: 150)
        }
    }
}

struct ExerciseDetailView: View {
    let exerciseName: String
    let exerciseDetail: String

    var body: some View {
        VStack(spacing: 20) {
            Text(exerciseName)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Text(exerciseDetail)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
        .padding(.top, 20)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseScreen()
    }
}
