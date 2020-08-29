//
//  TimerView.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/16/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel: viewModelTimer = viewModelTimer()
    @EnvironmentObject var user: viewModelProfile
    @State var complete:Bool = false
    @Binding var friendActive: Bool
    let friend = "Kevin O'Leary"
    
    var body: some View {
        return
            GeometryReader{ geometry in
                self.body(geometry.size)
        }
    }
    
    func body(_ size: CGSize)-> some View{
        ZStack {
            Rectangle().fill().foregroundColor(friendActive ? Color.aqua : backgroundColor) // background state 2
            
            VStack(){
                Text("You're reading: The Grapes of Wrath").font(.custom(Global.medItalicFont, size: size.height*Global.smallScale)).foregroundColor(Color.white).padding()
                if friendActive{
                    Text("\(friend) is reading: From Rags To Riches").font(.custom(Global.medItalicFont, size: size.height*Global.smallScale)).foregroundColor(Color.white).padding()
                }
                
                ZStack{
                    if self.friendActive{
                        Image("invismantimer").resizable().aspectRatio(contentMode: .fit).modifier(Borderify(size: size))
                        Image("\(user.getImage())timer").resizable().aspectRatio(contentMode: .fit).modifier(Borderify(size: size, friend: true)).scaleEffect(0.5).offset(x: -1*size.height*0.15, y: size.height*0.15)
                    }
                    else{
                        Image("\(user.getImage())timer").resizable().aspectRatio(contentMode: .fit).modifier(Borderify(size: size))
                    }
                
                }
                Text("\(viewModel.displayTime())")
                    .font(Font.custom("SFProDisplay-Thin", size: fontSize(size))) .foregroundColor(timeColor)
                
                Button(action:{
                    
                    withAnimation{
                    self.complete = true
                    }
                    self.viewModel.stop()
                    //
                }, label:{
                    ButtonShape(heightRatio: 0.07, widthRatio: 0.5, size:size, buttonColor: Color.dimBlue, text: "S T O P", textColor: Color.white)
                    
                }).disabled(self.complete ? true: false)
                
            }
            
            if complete{
                Color.dropLight.animation(.easeIn)
                PopUp(viewModel: viewModel,complete: self.$complete, friendActive: self.$friendActive, size: size).transition(.move(edge: .leading))
            }
            
            
        }.edgesIgnoringSafeArea(.vertical)
    }
    
    func fontSize(_ size:CGSize)->CGFloat{
        return size.width*fontScale
        
    }
    
    
    
    //MARK: - Drawing Constants
    let fontScale:CGFloat = 0.25
    let backgroundColor = Color.offBlue
    let timeColor = Color.white
}




struct PopUp: View{
    @EnvironmentObject var user: viewModelProfile
    @EnvironmentObject var nav: Navigation
    var viewModel: viewModelTimer
    @Binding var complete:Bool
    @Binding var friendActive: Bool
    
    

    var size: CGSize
    var body: some View{
        self.main()
    }
    
    func main() -> some View{
        
        VStack(spacing:0){
            Text("Great Work!").font(.custom(boldFont, size: fontSize(size, scalar: achievmentMessageSize))).padding().padding(.top).foregroundColor(Color.black)
            
            
            VStack(spacing:0){
                Text("You read for").font(.custom(regularFont, size: fontSize(size, scalar: basicFontSize))).foregroundColor(Color.black)

                Text("\(viewModel.getMinutes()) min \(viewModel.getSeconds()) s").font(.custom(boldFont, size: fontSize(size, scalar: midScalar))).foregroundColor(Color.darkBlue).padding()

                Text("and earned").font(.custom(regularFont, size: fontSize(size, scalar: basicFontSize))).foregroundColor(Color.black)
                
                HStack{
                    Image(systemName: "bitcoinsign.circle.fill")
                    Text("\(viewModel.currencyForTime()) Coins")
                    
                }.font(.custom(boldFont, size: fontSize(size, scalar: midScalar))).foregroundColor(Color.tangerine).padding()
            }
            
            VStack(spacing:0){
                
                HStack{
                    Image(systemName: "flame")
                    Text("4 day streak!").font(.custom(italicFont, size: fontSize(size, scalar: basicFontSize)))
                }.foregroundColor(Color.red)
                Button(action: {
                    self.nav.state = nil
                    self.user.processTime(min: self.viewModel.getMinutes(), sec: self.viewModel.getSeconds(),gain: self.viewModel.currencyForTime())
                    self.friendActive = false 
                }){
                     ButtonShape(heightRatio: 0.07, widthRatio: 0.44, size: size, buttonColor: Color.offOrange, text: "D O N E", textColor: Color.white)
                    
                    }
                
                
               
            }.padding().padding(.bottom)
        }.frame(width: 0.7*size.width, height: 0.5*size.height)
            .background(RoundedRectangle(cornerRadius: 17).foregroundColor(Color.white))
        
        
        
        
    }
    
    let achievmentMessageSize:CGFloat = 0.04
    let basicFontSize:CGFloat = 0.026
    let midScalar: CGFloat = 0.035
    let regularFont: String = "SFProDisplay-Regular"
    let italicFont: String = "SFProDisplay-ThinItalic"
    let boldFont: String = "SFProDisplay-Bold"
    
    func fontSize(_ size: CGSize, scalar: CGFloat)->CGFloat{
        return size.height*scalar
    }
    
    
}



