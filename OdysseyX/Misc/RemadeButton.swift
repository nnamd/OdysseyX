//
//  File.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/23/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import SwiftUI


struct ButtonShape: View{
    
    var heightRatio: CGFloat
    var widthRatio: CGFloat
    var size: CGSize
    var buttonColor: Color
    var text: String
    var textColor: Color
    var textRatio:CGFloat = 0.25
    var font: String = "SFProDisplay-Regular"
    var dropShadow: Bool = true

    
    var body:some View{
            return self.button()
        }
    

    
    func button()->some View{
        
        return ZStack{
            Capsule().frame(width: size.width*widthRatio, height: size.height*heightRatio).foregroundColor(buttonColor).shadow(radius: dropShadow ? 2 : 0)
        Text("\(text)").font(.custom(font, size: fontSize())).foregroundColor(textColor)
                  }.frame(width: size.width*widthRatio, height: size.height*heightRatio)
                

    }
    
    
    func fontSize()->CGFloat{
        return size.height*heightRatio*textRatio
    }
    
    
}


