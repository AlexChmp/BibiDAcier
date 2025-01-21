import SwiftUI
import PhotosUI

struct ProfilePage: View {
    @State private var nom: String = ""
    @State private var prenom: String = ""
    @State private var age: String = ""
    @State private var poids: String = ""
    @State private var taille: String = ""

    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?

    let verticalPaddingForForm: CGFloat = 20

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
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
                }
                .navigationTitle("Profil")
                .padding(.top, 20)
            }
        }
    }
}

struct PreviewTest: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
