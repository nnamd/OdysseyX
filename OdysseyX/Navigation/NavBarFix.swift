//
//  NavBarFix.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/23/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import SwiftUI

struct NavBarFix: ViewModifier{
    
    func body(content: Content) -> some View {
        content.navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }

}

extension View{
    
    func noBar()-> some View{
        return self.modifier(NavBarFix())
    }
    
}
