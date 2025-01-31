//
//  TestSendData.swift
//  BibiDAcier
//
//  Created by neoxia on 31/01/2025.
//

import Foundation
import SwiftUI

public class TestSendData: View {
    var userService = UserService()
    let user = User(name: "Alexandre", firsName: "Champier", age: 12, height: 190, profilePicture: "", weight: 1000)
    
    var body: some View {
        Button("send Data", {
            userService.addUser(user: user, completion: {})
        })
    }
}
