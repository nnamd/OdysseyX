//
//  BookOfTheDay.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 8/2/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import SwiftUI

struct BookOfTheDay: View {
    @State var blurb = false
    
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                VStack{
                    VStack(spacing: 0){
                        Text("Book of the Day").font(.custom(Global.boldFont, size: Global.midScale*geometry.size.height)).foregroundColor(Color.black)
                        Text("Based on the books you've read, you might like this one:").multilineTextAlignment(.center).font(.custom(Global.thinFont, size: Global.smallScale*geometry.size.height)).foregroundColor(Color.black)
                    }.padding()
                    Divider().frame(height: geometry.size.height*0.02).background(Color.offGray)
                    Image("book1").resizable().aspectRatio(contentMode: .fit).frame(height: 0.47*geometry.size.height)
                    Text("The Princess Bride").font(.custom(Global.boldFont, size: Global.midScale*geometry.size.height)).foregroundColor(Color.black)
                    Text("by William Goldsman").font(.custom(Global.thinFont, size: Global.midScale*geometry.size.height)).foregroundColor(Color.black)
                    Text("Genre: Comedy").font(.custom(Global.boldFont, size: Global.midScale*geometry.size.height)).foregroundColor(Color.black)
                    
                    Button(action:{
                        self.blurb = true
                    }){
                    ButtonShape(heightRatio: 0.06, widthRatio: 0.37, size: geometry.size, buttonColor: Color.offBlue, text: "READ BLURB", textColor: Color.white, textRatio: 0.3, font: Global.boldFont)
                    }.padding()

                
                }
                MainMenuTopBar()
                
                if self.blurb{
                    Color.dropLight.edgesIgnoringSafeArea(.vertical).onTapGesture {
                        self.blurb = false
                    }
                    self.popUp(size: geometry.size)
                }
            }.background(Color.offGray.edgesIgnoringSafeArea(.vertical))
        }
    }
    
    func popUp(size: CGSize)-> some View{
        return VStack{
        ScrollView{
            Divider().frame(width: size.width*0.6, height: 2).background(Color.offBlue)
            Text("SYNOPSIS").font(.custom(Global.boldFont, size: size.height*Global.midScale)).foregroundColor(Color.weirdOrange)
            Divider().frame(width: size.width*0.6, height: 2).background(Color.offBlue)
                Group{
                Text("What happens when the most beautiful girl in the world marries the handsomest prince of all time and he turns out to be...well...a lot less than the man of her dreams?")
                Text("As a boy, William Goldman claims, he loved to hear his father read the S. Morgenstern classic, The Princess Bride. But as a grown-up he discovered that the boring parts were left out of good old Dad's recitation, and only the \"good parts\" reached his ears.")
                Text("Now Goldman does Dad one better. He's reconstructed the \"Good Parts Version\" to delight wise kids and wide-eyed grownups everywhere.")
                Text("What's it about? Fencing. Fighting. True Love. Strong Hate. Harsh Revenge. A Few Giants. Lots of Bad Men. Lots of Good Men. Five or Six Beautiful Women. Beasties Monstrous and Gentle. Some Swell Escapes and Captures. Death, Lies, Truth, Miracles, and a Little Sex.")
                Text("In short, it's about everything.")
                    
                }.font(.custom(Global.regularFont, size: size.height*Global.smidScale)).foregroundColor(Color.black).multilineTextAlignment(.leading).padding()
            }
        }.frame(width: size.width*0.8, height: size.height*0.5).padding().background(RoundedRectangle(cornerRadius: 17).foregroundColor(Color.white))
        
        
        
        
    }
    
    
    
    
}

struct BookOfTheDay_Previews: PreviewProvider {
    static var previews: some View {
        BookOfTheDay()
    }
}
