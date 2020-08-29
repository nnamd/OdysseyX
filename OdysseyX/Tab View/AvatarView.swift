//
//  LibraryView.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/24/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import SwiftUI

struct AvatarView: View {
    @EnvironmentObject var nav: Navigation
    @EnvironmentObject var user: viewModelProfile
    @ObservedObject var shop: StoreController = StoreController()
    @State var displayedAvatar: String?
    
    
    var body: some View {
        let characterOnScreen: Character = shop.currentCharacter()
        
        let alreadyOwned: Bool = user.ownedAvatars().containsID(matching: characterOnScreen)
        
        return GeometryReader{ geometry in
            ZStack{
                
                Color.darkBlue
                
                VStack(spacing: 0){
                    Text("The Traveling Library").font(.custom(Global.boldFont, size: geometry.size.height*Global.midScale)).foregroundColor(Color.libraryOrange).padding()
                    
                    PurchaseAvatar(name: characterOnScreen.name, avatar: characterOnScreen.nickname, size: geometry.size, price: characterOnScreen.price, description: characterOnScreen.description).transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                    
                    
                    VStack(spacing:0){
                        Text("Time remaining: \(characterOnScreen.timeRemaining)").font(.custom(Global.regularFont, size: geometry.size.height*Global.smallScale)).foregroundColor(Color.white)
                        
                        Button(action:{
                            self.user.buyAvatar(option: characterOnScreen)
                        },label:{
                            ButtonShape(heightRatio: 0.08, widthRatio: 0.45, size: geometry.size, buttonColor: alreadyOwned ? Color.lightGray : Color.weirdOrange, text: alreadyOwned ? "OWNED": "BUY", textColor: Color.black, textRatio: 0.32, font: "SFProDisplay-Bold").padding()
                        }).disabled(alreadyOwned ? true : false)
                        
                        Text("Purchase to read their story!").font(.custom(Global.italicFont, size: geometry.size.height*Global.smallScale)).foregroundColor(Color.white)
                    }
                    
                }
                
                
                
                arrowOverlay(shop: self.shop)
                
            }
            
        }
        
        
        
        
    }
    
    let boldFont = "SFProDisplay-Bold"
    let italicFont = "SFProDisplay-ThinItalic"
    let regularFont = "SFProDisplay-Regular"
    let smallScale: CGFloat = 0.02
    let midScale: CGFloat = 0.03
    let bigScale: CGFloat = 0.044
    let imageScale: CGFloat = 0.48
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}

struct PurchaseAvatar: View{
    
    @EnvironmentObject var user: viewModelProfile
    @EnvironmentObject var nav: Navigation
    var name: String
    var avatar: String
    var size: CGSize
    var price: Int
    var description: String
    
    var body: some View{
        
        return Group{
            Text(name).font(.custom(self.boldFont, size: size.height*self.bigScale)).foregroundColor(Color.white).shadow(radius: 4, y:4).padding(.top)
            
            Text(description).font(.custom(self.italicFont, size: size.height*self.smallScale)).foregroundColor(Color.white)
            
            
            Image(avatar + "base").resizable().aspectRatio(contentMode:.fit)
                .frame(height: size.height*self.imageScale)
            
            
            HStack{
                Image(systemName: "bitcoinsign.circle.fill").foregroundColor(Color.libraryOrange)
                Text("\(price)").foregroundColor(Color.white)
                
            }.font(.custom(self.boldFont, size: size.height*self.midScale))
            
            
        }
    }
    
    
    let boldFont = "SFProDisplay-Bold"
    let italicFont = "SFProDisplay-ThinItalic"
    let regularFont = "SFProDisplay-Regular"
    let smallScale: CGFloat = 0.02
    let midScale: CGFloat = 0.03
    let bigScale: CGFloat = 0.044
    let imageScale: CGFloat = 0.48
    
}


struct arrowOverlay: View{

    @ObservedObject var shop: StoreController
    
    var body: some View{
        GeometryReader{ geometry in
            HStack{
                Group{
                    Image(systemName: "chevron.left.2").resizable().aspectRatio(contentMode: .fit).frame(width: geometry.size.width*0.08).onTapGesture {
                        self.shop.prevCharacter()
                    }
                    Spacer()
                    Image(systemName: "chevron.right.2").resizable().aspectRatio(contentMode: .fit).frame(width: geometry.size.width*0.08).onTapGesture {
                        self.shop.nextCharacter()
                    }
                }.padding().foregroundColor(Color.badYellow).shadow(radius: 4, y: 4)
            }.offset(y: -1*geometry.size.height/12)
        }
    }
    
}
