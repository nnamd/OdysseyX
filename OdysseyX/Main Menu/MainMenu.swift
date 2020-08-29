//
//  MainMenu.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/20/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import SwiftUI

struct MainMenu: View {
    @EnvironmentObject var user: viewModelProfile
    @Binding var showMenu: Bool 
    
    let tabScalar:CGFloat = 0.65
    var body: some View {
        return GeometryReader{ geometry in
            ZStack {
                
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white)
                    .frame(width: geometry.size.width*self.tabScalar).edgesIgnoringSafeArea(.vertical)
                VStack {
                    Spacer()
                    profileBox(user: self.user)
                    NavMenu(showMenu: self.$showMenu).frame(width:geometry.size.width*self.tabScalar, alignment: .leading)

                    
                }
            }.frame(alignment:.topLeading)
                .offset(x: -geometry.size.width*(1-self.tabScalar)/2)
        }
    }
    
    
    
    //MARK: - Drawing Constants
    let leadingSpacing:CGFloat = 20
    let menuSpacing:CGFloat = 10
    let fontSize: CGFloat = 16
    let profilePic: CGFloat = 90
    let topSpacing: CGFloat = 40
}



extension View{
    
    func lean(_ size: CGSize)->some View{
        self.frame(width:size.width, alignment: .leading)
            .foregroundColor(Color.black)
    }
}

struct NavMenu: View{
    @EnvironmentObject var nav: Navigation
    @Binding var showMenu: Bool
    
    var body: some View{
    Group{
        Row(icon: "person", text: "My Profile")
            Row(icon: "bookmark", text: "Avatars").onTapGesture {
                self.nav.state = "avatarlib"
                self.showMenu = false 
            }
            Row(icon: "globe", text: "Friends List")
            Row(icon: "book", text: "Book Of The Day").onTapGesture {
                self.nav.state = "botd"
                self.showMenu = false
            }
            Row(icon: "cart", text: "Coin Shop")
            Row(icon: "gear", text: "Settings")
            Spacer()
            Row(icon: "icloud.slash", text: "Log Out")
            Spacer()
    }.foregroundColor(Color.black)
}
    
    
}


struct profileBox: View{
    var user: viewModelProfile
    var body: some View{
            return VStack(spacing:0){
                Image("\(user.getImage())profile").resizable().aspectRatio(contentMode: .fit).frame(width: self.photoSize,height:self.photoSize).padding(.top, self.topSpacing)
                Text("\(user.getUserName())").foregroundColor(Color.darkBlue)
                           .font(Font.custom(self.fontProfile, size: self.fontSize))
            
            }.padding()
                
        }
    //MARK: - Constants
    let fontSize: CGFloat = 16
    let fontProfile = "SFProDisplay-Regular"
    let photoSize:CGFloat = 90
    let topSpacing: CGFloat = 50
}
struct Row: View{
    var icon: String
    var text: String
    
    var body: some View{

        HStack{
            Image(systemName: icon).font(Font.custom(self.font, size: self.imageSize)).padding()
            Text(text).font(Font.custom(self.font, size: self.fontSize))
        }.padding(.leading)
    }
    let fontSize: CGFloat = 16
    let font:String = "SFProDisplay-Semibold"
    let imageSize: CGFloat = 22
}





