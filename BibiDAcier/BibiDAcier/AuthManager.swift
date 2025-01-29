//
//  AuthManager.swift
//  BibiDAcier
//
//  Created by neoxia on 28/01/2025.
//
import SwiftUI
import FirebaseAuth
import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    public func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        
    }
    
    public func veridyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        
    }
}
