//
//  CustomTabBar.swift
//  BibiDAcier
//
//  Created by neoxia on 13/01/2025.
//

import SwiftUI

enum Tabs: Int {
  case list = 0
  case timer = 1
  case programme = 2
  case profil = 3
}


struct CustomTabBar: View {

    @Binding var selectedTab: Tabs

    var body: some View {
        HStack {
            Button {
                selectedTab = .list
            } label:{
                VStack(alignment: .center, spacing: 4){
                    Image("list_icon_unselected")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
    
                    Text("List")
                }
                
            }
            
            Button {
                selectedTab = .timer
            } label:{
                VStack(alignment: .center, spacing: 4){
                    Image("timer_icon_unselected")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text("Timer")
                }
                if selectedTab == .timer{
                    Image("timer_icon_selected")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                }
            }
            
            Button {
                selectedTab = .programme
            } label:{
                VStack(alignment: .center, spacing: 4){
                    Image("programme_icon_unselected")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text("Programme")
                }
                
            }
            
            Button {
                selectedTab = .profil
            } label:{
                VStack(alignment: .center, spacing: 4){
                    Image("profil_icon_unselected")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text("Profil")
                }
                
            }


        }
        .frame(height: 82)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.list))
    }
}


