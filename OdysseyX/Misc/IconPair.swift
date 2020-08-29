//
//  IconPair.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/29/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import SwiftUI

struct IconPair : View {
    
    var size: CGSize
    var image: String
    var text: String
    var textScalar: CGFloat = 0.03
    var iconScalar: CGFloat = 0.05
    
    var body:some View{
        
        VStack{
            Image(systemName: image).resizable().frame(width:size.width*self.iconScalar,height:size.width*self.iconScalar)
            Text(text).font(.system(size: size.width*self.textScalar))
            
        }.padding()
        
        
        
    }
    
}
