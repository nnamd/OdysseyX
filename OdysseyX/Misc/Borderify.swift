//
//  Borderify.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/17/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import SwiftUI


struct Borderify: ViewModifier{
    var size: CGSize
    var friend = false
    
    func body(content: Content) -> some View {
            self.main(content: content)
    }
    
    func main(content:Content)-> some View{
        return ZStack{
            Circle().stroke(lineWidth:circleThickness)
                .frame(width: size.height*circleScale, height: size.height*circleScale)
                .offset(y:size.height*offset)
                .shadow(color: .dropShadow, radius: 0.1)
        
            if friend {
            Circle()
            .frame(width: size.height*circleScale, height: size.height*circleScale)
                 .offset(y:size.height*offset)
                .foregroundColor(Color.offGray)
            }
            
            
            Circle()
                .trim(from: 0.5, to: 1)
            .stroke(lineWidth:circleThickness)
            .frame(width: size.height*circleScale, height: size.height*circleScale)
                .offset(y: size.height*offset)
                .foregroundColor(friend ? Color.darkBlue : Color.evenDimmerBlue)
            // .shadow(radius: 1, x:2, y:5)
  
            
            content.frame(width:size.height*0.33,height:size.height*0.33)
            Circle()
            .trim(from: 0, to: 0.5)
            .stroke(lineWidth:circleThickness)
            .frame(width: size.height*circleScale, height: size.height*circleScale)
            .offset(y: size.height*offset)
                .foregroundColor(friend ? Color.darkBlue : Color.evenDimmerBlue)


            }
        }
      
    
     let circleRadius: CGFloat = 267
     let circleThickness: CGFloat = 17
     let imageSize: CGFloat = 270
    let circleScale: CGFloat = 0.3
    let offset: CGFloat = 0.022
    let xShadowOffset: CGFloat = 0
    let yShadowOffset: CGFloat = 0.153
    
    }





