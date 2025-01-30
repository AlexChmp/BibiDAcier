//
//  ContentView.swift
//  testCo
//
//  Created by Calvignac Charles on 29/01/2025.
//

import SwiftUI

import SwiftUI
import FirebaseAuth

struct PhoneNumberView: View {
    @State private var phoneNumber = ""
    @State private var isShowingOTPView = false
    var onLoginSuccess: () -> Void  // Callback pour informer de la réussite de la connexion
    
    var body: some View {
        VStack {
            Text("Entrez votre numéro de téléphone")
                .font(.title2)
                .padding()
            
            TextField("+33 6 12 34 56 78", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.phonePad)
                .padding()
            
            Button("Envoyer le code") {
                sendCode()
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .fullScreenCover(isPresented: $isShowingOTPView) {
            OTPVerificationView(phoneNumber: phoneNumber, onLoginSuccess: onLoginSuccess)
        }
    }
    
    func sendCode() {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                print("Erreur: \(error.localizedDescription)")
                return
            }
            if let verificationID = verificationID {
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                print("@@@ here")
                isShowingOTPView = true
            }
        }
    }
}


struct OTPVerificationView: View {
    var phoneNumber: String
    @State private var otpCode = ""
    @Environment(\.dismiss) var dismiss
    var onLoginSuccess: () -> Void  // Callback pour informer du succès de la connexion
    
    var body: some View {
        VStack {
            Text("Entrez le code reçu")
                .font(.title2)
                .padding()
            
            TextField("123456", text: $otpCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()
            
            Button("Valider") {
                verifyCode()
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    func verifyCode() {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otpCode)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Erreur: \(error.localizedDescription)")
                return
            }
            print("Connexion réussie ✅")
            onLoginSuccess()  // Appelle le callback après une connexion réussie
            dismiss()
        }
    }
}

