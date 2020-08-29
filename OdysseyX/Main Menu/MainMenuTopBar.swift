//
//  MainMenuTopBar.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 8/2/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import SwiftUI

struct MainMenuTopBar: View {
    @EnvironmentObject var nav: Navigation
    var body: some View{
        return GeometryReader{ geometry in
            VStack {
                
                HStack(spacing:0){
                    Button(action: {
                        self.nav.state = nil
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.subheadline).foregroundColor(Color.black)
                        
                    }).padding().padding(.top).padding(.leading).padding(.top).padding(.top).buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                }.frame(width: geometry.size.width, height: self.topBarScalar*geometry.size.height)
                
                
                Spacer()
            }.edgesIgnoringSafeArea(.top)
        }
    }
    let topBarScalar:CGFloat = 0.12
    let topBarCenter:CGFloat = 0.25
}

struct MainMenuTopBar_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuTopBar()
    }
}
