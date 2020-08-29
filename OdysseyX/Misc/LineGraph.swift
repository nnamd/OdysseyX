//
//  LineGraph.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/30/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import SwiftUI

struct LineGraphView: View {
    var size: CGSize
    @State var on = true
    let circleScalar: CGFloat = 0.05
    var data: [CGFloat] = [5,10,8,1,4,9,12]
    var daysOftheWeek: [String] = ["S","M", "T", "W", "TH", "F","S"]
    
    var body: some View {
        
        return self.main()
    }
    
    func main()-> some View{
        VStack{
            ZStack(){
            LineGraph(dataPoints: data,circleScalar: circleScalar).stroke(lineWidth: 2).trim(to: self.on ? 1 : 0)
                .frame(width: size.width*0.8,height: size.height*0.25, alignment: .center).foregroundColor(Color.black)
                
            self.makeCircles(sampleData: data)
          
            }
              labeling()
            
            
        }
        
    }
    
    
    
    func makeCircles(sampleData: [CGFloat])-> some View{
        
        let circleDiameter: CGFloat = size.width*circleScalar
        let frameHeight: CGFloat = size.height*0.25
        let frameWidth: CGFloat = size.width*0.8
        let maxValue: CGFloat = sampleData.max()!
        let breakdown:CGFloat = frameHeight/CGFloat(maxValue)
        
        
        
        return HStack(spacing: (frameWidth -  CGFloat(sampleData.count)*circleDiameter)/CGFloat(sampleData.count-1)){
            ForEach(0...sampleData.count-1, id:\.self){ data in
                Circle().foregroundColor(Color.newOrange)
                    .frame(width:circleDiameter,height:circleDiameter)
                    .offset(y: breakdown*((maxValue/2)-sampleData[data])).onTapGesture {
                        print("working \(data)")
                }
            }
            
            }.frame(width: frameWidth, height:frameHeight)
        
    }
    
    func labeling()->some View{
        
        return HStack{
            ForEach(daysOftheWeek, id: \.self){ day in
                Text(day).font(.custom("SFProDisplay-Thin", size: self.size.height*Global.smallScale)).padding(.leading).padding(.trailing)
                
            }
        }
    }
        
    }


struct LineGraph: Shape {
    var dataPoints: [CGFloat]
    var circleScalar: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let maxValue: CGFloat = CGFloat(dataPoints.max()!)
        let numberOfDataPoints = dataPoints.count
        let numberOfPointsAsCGFloat: CGFloat = CGFloat(numberOfDataPoints)
        
        
        let circleScaling:CGFloat = (rect.maxX - rect.minX)*(circleScalar/2)
        let circleRadius: CGFloat = circleScaling
        let spacingY = (rect.maxY - rect.minY)/(maxValue)
        let spacingX = (rect.maxX - rect.minX - 2*circleScaling)/(numberOfPointsAsCGFloat-1)
        
        var intialX: CGFloat = rect.minX + circleRadius
        
        path.move(to: CGPoint(x: intialX, y:rect.maxY - spacingY*dataPoints[0]))
        
        
        
        for entry in 1...numberOfDataPoints-1{
            intialX += spacingX
            
            path.addLine(to: CGPoint(x: intialX, y:rect.maxY-spacingY*dataPoints[entry]))
            
        }
        
        
        return path
    }
}

