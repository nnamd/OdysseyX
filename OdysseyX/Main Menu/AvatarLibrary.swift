//
//  SwiftUIView.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/27/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import SwiftUI

struct AvatarLibraryView: View {
    @EnvironmentObject var user: viewModelProfile
    @EnvironmentObject var nav: Navigation
    @State var selectedChar: Int = 0
    @State var popUp:Bool = false
    
    var body: some View {
        let equippedCharacter: Character = user.equippedCharacter()
        
        return GeometryReader{ geometry in
            self.body(size: geometry.size, character: equippedCharacter)
            
        }.background(Color.white.edgesIgnoringSafeArea(.vertical))
    }
    
    func body(size: CGSize, character: Character)-> some View{
        let listAvatars = user.ownedAvatars()
        let characterInPosition = listAvatars[selectedChar]
        
        return ZStack{
            
            VStack(spacing:0){
                Text("Your Avatar Library").font(.custom(Global.boldFont, size: size.height*Global.midScale)).foregroundColor(Color.black).padding().padding(.bottom).padding(.top)
                Image(characterInPosition.nickname + "base").resizable().aspectRatio(contentMode: .fit).frame(height: size.height*0.6).offset(x:-1*size.width/20)
                Divider().frame(width: size.width*0.8, height: 2).background(Color.tangerine)
                VStack(){
                    Text(characterInPosition.name).font(.custom(Global.boldFont, size: size.height*Global.midScale)).foregroundColor(Color.black)
                    Text(characterInPosition.description).font(.custom(Global.italicFont, size: size.height*Global.smallScale)).foregroundColor(Color.black)
                }
                Divider().frame(width: size.width*0.8, height: 2).background(Color.tangerine)
                bottomBar(size: size)
            }

            
            
            
            
            
            
            sideBar(size: size, character: character)
            
            MainMenuTopBar()
            if popUp {
                Color.dropLight.edgesIgnoringSafeArea(.vertical).onTapGesture {
                    self.popUp = false
                }
                PopUp(size: size)
            }
        }
        
    }
    
    func bottomBar(size: CGSize) -> some View{
        let listAvatars: [Character] = user.ownedAvatars()
        let characterInPosition = listAvatars[selectedChar]
        
        
        return ScrollView(.horizontal){
            HStack(){
                ForEach(0...listAvatars.count-1, id: \.self){ position in
                    Image(listAvatars[position].nickname + "lib").resizable().aspectRatio(contentMode: .fit)
                        .frame(width: size.width/5)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color.offBlue))
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.almostGray,lineWidth: 2)
                            .shadow(radius: 10))
                        .background(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.tangerine,lineWidth: characterInPosition.nickname == listAvatars[position].nickname ? 8 : 0))
                        .padding(.top)
                        .onTapGesture {
                            self.selectedChar = position
                    }
                }
            }.padding()
            
        }
    }
    
    func PopUp(size: CGSize)-> some View{
        let listAvatars: [Character] = user.ownedAvatars()
        return VStack{
            ScrollView{
            Divider().frame(width: size.width*0.6, height: 2).background(Color.offBlue)
            Text("STORY").font(.custom(Global.boldFont, size: size.height*Global.midScale)).foregroundColor(Color.weirdOrange)
            Divider().frame(width: size.width*0.6, height: 2).background(Color.offBlue)
                Text("\(listAvatars[selectedChar].story)").font(.custom(Global.regularFont, size: size.height*Global.smidScale)).foregroundColor(Color.black).multilineTextAlignment(.leading).padding()
            }
        }.frame(width: size.width*0.8, height: size.height*0.5).padding().background(RoundedRectangle(cornerRadius: 17).foregroundColor(Color.white))
        
    }
    
    func sideBar(size: CGSize, character: Character) -> some View{
        let listAvatars: [Character] = user.ownedAvatars()
        let characterInPosition = listAvatars[selectedChar]
        
        
            return HStack{
                Spacer()
                VStack{
                Spacer()
                Group{
                    IconPair(size: size, image: "book", text:"View Story").foregroundColor(Color.darkBlue).onTapGesture {
                        self.popUp = true
                    }
                    IconPair(size: size, image: character.nickname == characterInPosition.nickname ? "star.fill":"star", text: character.nickname == characterInPosition.nickname ? "Favorited": "Favorite").foregroundColor(Color.tangerine).onTapGesture{
                        self.user.changeAvatar(to: characterInPosition)                    }
                    IconPair(size: size, image: "arrow.up.left.and.arrow.down.right", text:"Full View").foregroundColor(Color.black)
                    IconPair(size: size, image: "map", text: "Caravan").foregroundColor(Color.red).onTapGesture{
                        self.nav.tabState = "avatar"
                        self.nav.state = nil
                    }
                }
                Spacer()
                Spacer()
                Spacer()
                    }
            }
            
        }
    
    
    let topBarScalar:CGFloat = 0.12
    let topBarCenter:CGFloat = 0.25
}







struct AvatarLibrary_Previews: PreviewProvider {
    static var previews: some View {
        AvatarLibraryView()
    }
}
