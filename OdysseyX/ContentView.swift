//
//  ContentView.swift
//  Odyssey
//
//  Created by Nnamdi Nwagwu on 7/13/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var showMenu = false //true means menu out
    @EnvironmentObject var nav: Navigation
    @State var paired: Bool = false
    @State var friendActive: Bool = false
    let menuRatio:CGFloat = 0.65
    
    var body: some View {
        let dragout = DragGesture()
            .onEnded{
                if $0.translation.width < -40{
                    withAnimation{
                        self.showMenu = false
                    }
                    
                }
        }
        return NavigationView{
            GeometryReader{ geometry in
                self.body(geometry.size)
                //check if Menu is open
                
            }.gesture(dragout)
                .noBar()
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    func body(_ size: CGSize)-> some View{
        return ZStack(alignment: .leading){
            NavigationLink(destination: TimerView(friendActive: self.$friendActive).noBar(), tag: "timer", selection: $nav.state, label: {EmptyView()})
            NavigationLink(destination: AvatarLibraryView().noBar(), tag: "avatarlib", selection: $nav.state, label: {EmptyView()})
            NavigationLink(destination: BookOfTheDay().noBar(), tag: "botd", selection: $nav.state, label: {EmptyView()})
            
            //MARK: - Tab View Controller
            Group{
                
                if (nav.tabState == nil){
                    MainView(showMenu: $showMenu, paired: self.$paired, friendActive: self.$friendActive).frame(width: size.width, height: size.height)
                        .font(.headline)
                }
                else if(nav.tabState == "analytics"){
                    AnalyticsView().frame(width: size.width, height: size.height)
                }
                else if(nav.tabState == "avatar"){
                    AvatarView().frame(width: size.width, height: size.height)
                        .font(.headline)
                }
                
                
                TopBar(size: size, showMenu: self.$showMenu)
                pointOverlay(size: size)
                TabBar()
                
                if showMenu{
                    Color.dropLight.edgesIgnoringSafeArea(.all)
                }
                
            }
            .offset(x:showMenu ? size.width*menuRatio : 0)
            .disabled(showMenu ? true:false)
            
            
            if showMenu{
                //Menu covers half the screen
                MainMenu(showMenu: self.$showMenu).frame(width:size.width)
                    .transition(.move(edge: .leading))
            }
        }
    }
    //MARK: - Home Screen
    struct MainView: View{
        
        @Binding var showMenu: Bool
        @EnvironmentObject var user: viewModelProfile
        @EnvironmentObject var nav: Navigation
        @Binding var paired: Bool
        @Binding var friendActive: Bool
        let friend = "Kevin O'Leary"
        var body: some View{
        
        let dragleft = DragGesture()
            .onEnded{
                if $0.translation.width < -40{
                    withAnimation{
                        self.paired.toggle()
                    }
                    
                }
        }
            
        let dragright = DragGesture()
            .onEnded{
                if $0.translation.width < 40{
                    withAnimation{
                        self.paired.toggle()
                    }
                }
            }
            
    
            return GeometryReader{ geometry in
                ZStack{
                    
                    Color.offGray
                    
                    VStack(spacing: 0){
                       
                        Text("Currently Reading: The Grapes of Wrath").font(.custom(Global.boldFont, size: geometry.size.height*Global.smallScale)).foregroundColor(Color.darkBlue).padding()
                        if self.paired{
                            HStack(alignment: self.friendActive ? .bottom : .center){
                                VStack{
                                    Text("\(self.user.getUserName())").font(.custom(Global.boldFont, size: geometry.size.height*Global.smallScale)).foregroundColor(Color.black)
                                    
                                    Image("\(self.user.getImage())base").resizable().aspectRatio(contentMode:.fit).frame(height: geometry.size.height*self.imageScale*0.75)
                                    Text(self.friendActive ? "Ready!" : "Waiting...").font(.custom(Global.italicFont, size: geometry.size.height*Global.smallScale)).foregroundColor(Color.black)
                                }
                                
                                
                                VStack(alignment: .center){
                                    Text(self.friendActive ? self.friend : "Companion").font(.custom(Global.boldFont, size: geometry.size.height*Global.smallScale)).foregroundColor(Color.black)
                                    if self.friendActive{
                                        Image("invismanbase").resizable().aspectRatio(contentMode:.fit).frame(height: geometry.size.height*self.imageScale*0.75)
                                        Text("Ready!").font(.custom(Global.italicFont, size: geometry.size.height*Global.smallScale))
                                    }
                                    else{
                                        VStack{
                                            Text("Reading doesn't have to be a lone jouney! Find someone to read with you!").font(.custom(Global.italicFont, size: geometry.size.height*Global.smallScale)).multilineTextAlignment(.center).foregroundColor(Color.black)
            
                                        VStack(spacing: 0){
                                            Button(action:{
                                                self.friendActive = true
                                            }){
                                                ButtonShape(heightRatio: 0.06, widthRatio: 0.37, size: geometry.size, buttonColor: Color.offOrange, text: "RANDOM MATCH", textColor: Color.black,textRatio: 0.3, font: Global.boldFont, dropShadow: false)
                                            }.padding()
                                            Button(action:{
                                                self.friendActive = true
                                            }){
                                                ButtonShape(heightRatio: 0.06, widthRatio: 0.37, size: geometry.size, buttonColor: Color.dimBlue, text: "CHOOSE A FRIEND", textColor: Color.black,textRatio: 0.3, font: Global.boldFont, dropShadow: false)
                                            }
                                            }
                                        }.frame(height: geometry.size.height*self.imageScale*0.75)
                                        Text(self.friendActive ? "Ready!": "Waiting...").font(.custom(Global.italicFont, size: geometry.size.height*Global.smallScale)).foregroundColor(Color.black)
                                    }
                                }
                               
                            }.frame(height: geometry.size.height*self.imageScale)
                        }
                        
                        else{
                        Image("\(self.user.getImage())base").resizable().aspectRatio(contentMode:.fit)
                            .frame(height: geometry.size.height*self.imageScale)
                        }
                        
                        
                        
                        Button(action:{
                            self.nav.state = "timer"
                        },label:{
                            ButtonShape(heightRatio: 0.1, widthRatio: 0.8, size: geometry.size, buttonColor: Color.darkBlue, text: "S T A R T  R E A D I N G", textColor: Color.almostGray)
                            }).padding()
                        
                        HStack{
                            Image(systemName: "circle.fill").font(.custom(Global.regularFont, size: geometry.size.height*0.01)).foregroundColor(self.paired ? Color.dropLight : Color.white.opacity(66))
                            Image(systemName: "circle.fill").font(.custom(Global.regularFont, size: geometry.size.height*0.01)).foregroundColor(self.paired ? Color.white.opacity(66) : Color.dropLight)
                        }
                        }.gesture(dragleft)
                        .gesture(dragright)
                }
            }
        }
        let imageScale: CGFloat = 0.52
    }
    //MARK: - Upper Menu Structs
    
    
    struct MenuButton: View{
        @Binding var showMenu: Bool
        @EnvironmentObject var nav: Navigation
        
        var body: some View{
            
            Button(action:{
                withAnimation{
                    self.showMenu.toggle()
                }
            }){
                Image(systemName: "line.horizontal.3")
                    .font(.largeTitle)
                    .foregroundColor(self.nav.tabState != nil ? Color.offGray : Color.darkBlue)
            }.buttonStyle(PlainButtonStyle())
            
        }
    }
    
    struct pointOverlay: View{
        @EnvironmentObject var user: viewModelProfile
        var size: CGSize
        var body: some View{
            return VStack {
                
                HStack(spacing:0){
                    Spacer()
                    
                    HStack{
                        Image(systemName: "bitcoinsign.circle.fill")
                        Text("\(self.user.getCurrency())").bold().padding()
                    }.frame(width: size.width*self.topBarCenter,height:size.height*self.topBarScalar, alignment: .bottom).foregroundColor(Color.tangerine)
                    
                }
                
                Spacer()
            }.edgesIgnoringSafeArea(.top)
        }
        
        
        let topBarScalar:CGFloat = 0.12
        let topBarCenter:CGFloat = 0.4
        
        
        
    }
    
    
  
    
    
    
    
    
    //MARK: - Home Page Structs
    struct TopBar: View{
        var size: CGSize
        @EnvironmentObject var nav: Navigation
        
        @Binding var showMenu: Bool
        
        
        var body: some View{
            return VStack {
                
                HStack(spacing:0){
                    MenuButton(showMenu: self.$showMenu).padding().frame(width: size.width*self.topBarCenter,height:size.height*self.topBarScalar, alignment: .bottom)
                    
                    Spacer()
                    
                }.frame(width: size.width, height: self.topBarScalar*size.height)
                    .background(nav.tabState == "avatar" ? Color.darkBlue : nav.tabState == "analytics" ? Color.offBlue: Color.white)
                
                Spacer()
            }.edgesIgnoringSafeArea(.top)
        }
        let topBarScalar:CGFloat = 0.12
        let topBarCenter:CGFloat = 0.25
    }
    
    struct TabBar: View{
        @EnvironmentObject var nav: Navigation
        
        
        var body: some View{
            GeometryReader{ geometry in
                VStack{
                    Spacer()
                    HStack(spacing:0){
                        Spacer()
                        IconPair(size: geometry.size, image: "timer", text: "Timer").foregroundColor(self.nav.tabState == nil ? Color.tangerine : Color.darkBlue)
                            .onTapGesture {
                                self.nav.tabState = nil
                        }
                        Spacer()
                        
                        
                        IconPair(size: geometry.size, image: "waveform", text: "Analytics").foregroundColor(self.nav.tabState == "analytics" ? Color.tangerine : Color.darkBlue)
                            .onTapGesture {
                                self.nav.tabState = "analytics"
                        }
                        
                        Spacer()
                        
                        IconPair(size: geometry.size, image: "map", text: "Library").foregroundColor(self.nav.tabState == "avatar" ? Color.tangerine : Color.darkBlue)
                            .onTapGesture {
                                self.nav.tabState = "avatar"
                        }
                        
                        Spacer()
                        
                    }.frame(width:geometry.size.width,height: geometry.size.height/10)
                        .background(Color.white.shadow(radius: 2))
                }.edgesIgnoringSafeArea(.bottom)
            }
            
            
            
            
            
        }
        
        
        
        
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View{
            ContentView()
        }
    }
}
