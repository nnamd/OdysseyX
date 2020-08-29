//
//  AnalyticsView.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/24/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import SwiftUI

func randomList()->[CGFloat]{
    var list: [CGFloat] = []
    
    for _ in 0..<7 {
        list.append(CGFloat.random(in:0...1))
    }
    return list
}

func arraySum(array: [CGFloat]) -> CGFloat{
    var sum: CGFloat = 0
    for index in array{
        sum += index
    }
    return sum
}

func standardDeviation(array: [CGFloat])-> CGFloat{
    var sum: CGFloat = 0
    for index in array{
        sum += index
    }
    let mean = sum/CGFloat(array.count)
    var squareSum:CGFloat = 0
    for index in array{
        squareSum += pow((index-mean), 2)
    }
    let underSqrt: CGFloat = squareSum/CGFloat(array.count)
    
    let standardDeviation: CGFloat = sqrt(underSqrt)
    
    return standardDeviation
}



struct AnalyticsView: View {
    @EnvironmentObject var user: viewModelProfile
    @State var expanded: Bool = true
    @State var input:[CGFloat] = randomList()
    @State var position: Int = 0
    let arrayOfDates: [String] = ["July 19 - July 25","July 26 - Aug 1","Aug 2 - Aug 8","Aug 9 - Aug 16"]
    
    var body: some View {
        GeometryReader{ geometry in
            self.body(size: geometry.size)
        }.background(Color.offBlue)
    }
    
    func body(size:CGSize)-> some View{
        
        return ScrollView{
            VStack{
                HStack{
                    Text("Weekly Report").font(.custom(Global.regularFont, size: size.height*Global.btwnScale))
                    Image(systemName: self.expanded ? "chevron.down" : "chevron.up")
                    }.padding().foregroundColor(Color.white).onTapGesture {
                    withAnimation{
                        self.expanded.toggle()
                    }
                }.frame(width: size.width).background(Color.offBlue).animation(nil)
                if(self.expanded){
                    LineGraphView(size: size, data: input).padding().background(RoundedRectangle(cornerRadius: 17).foregroundColor(Color.white).shadow(color: Color.dropLight.opacity(50), radius: 1)).transition(.move(edge:.top))
                    
                    changeDates(size: size)
                    weeklyStats(size: size)
                }
                suggesetedBox(size: size).padding()
                overallStatistics(size: size)
                
                
                
                // for animation correction
                HStack{Spacer()}
            }
        }.offset(y:size.height*Global.topBarScalar)
        
        
    }
    //sift through dates
    func changeDates(size: CGSize)-> some View{
        return HStack{
            Image(systemName: "chevron.left").onTapGesture {
                self.input = randomList()
                if self.position >= 1{
                    self.position -= 1
                }
            }
            Text(arrayOfDates[position]).font(.custom(Global.regularFont , size: size.height*Global.midScale)).padding().padding(.trailing).padding(.leading)
            Image(systemName: "chevron.right").onTapGesture {
                self.input = randomList()
                if self.position < self.arrayOfDates.count-1{
                    self.position += 1
                }
            }
        }.foregroundColor(Color.white)
        
    }
    
    func weeklyStats(size: CGSize)-> some View{
        let totalHrs: CGFloat = arraySum(array: input)
        let avgHrs: CGFloat = totalHrs/CGFloat(input.count)
        
        return HStack{
            VStack{
                Text("TOTAL HRS").font(.custom(Global.thinFont, size: size.height*Global.smallScale)).foregroundColor(Color.offGray)
                Text("\(totalHrs, specifier: "%.2f")").font(.custom(Global.regularFont, size: size.height*Global.btwnScale))
            }.padding()
            VStack{
                Text("AVG DAILY HRS").font(.custom(Global.thinFont, size: size.height*Global.smallScale)).foregroundColor(Color.offGray)
                Text("\(avgHrs, specifier: "%.2f")").font(.custom(Global.regularFont, size: size.height*Global.btwnScale))
            }.padding()
            VStack{
                Text("DEVIATION").font(.custom(Global.thinFont, size: size.height*Global.smallScale)).foregroundColor(Color.offGray)
                Text("+\(standardDeviation(array: input), specifier: "%.2f")").font(.custom(Global.regularFont, size: size.height*Global.btwnScale))
            }.padding()
        }
        .foregroundColor(Color.white)
        
        
    }
    
    func suggesetedBox(size: CGSize)-> some View{
        
        VStack{
            Text("Suggested Reading Schedule").font(.custom(Global.regularFont , size: size.height*Global.midScale)).foregroundColor(Color.offBlue)
            
            HStack{
                Text("Tuesdays").padding(.trailing).foregroundColor(Color.black)
                Text("2-5 PM").padding(.leading).foregroundColor(Color.tangerine)
                }.font(.custom(Global.regularFont , size: size.height*Global.midScale)).padding()
            HStack{
                Text("Wednesdays").padding(.trailing).foregroundColor(Color.black)
                Text("9-11 AM").padding(.leading).foregroundColor(Color.tangerine)
                }.font(.custom(Global.regularFont , size: size.height*Global.midScale)).padding()
            HStack{
                Text("Fridays").padding(.trailing).foregroundColor(Color.black)
                Text("4-6 PM").padding(.leading).foregroundColor(Color.tangerine)
                }.font(.custom(Global.regularFont , size: size.height*Global.midScale)).padding()
        }.frame(width: size.width*0.85).padding().background(RoundedRectangle(cornerRadius: 17).foregroundColor(Color.white).shadow(radius: 1))
        
    }
    
    func overallStatistics(size: CGSize)-> some View{
        
        return VStack{
            
            Text("Statistics").padding()
            Text("Total Time Read: \(user.getTotalTime().min) min \(user.getTotalTime().sec) s").padding()
            Text("Number of Books Read: \(user.numberOfBooks())").padding()
            Divider().frame(width: size.width, height: size.height*0.3)
            
        }.foregroundColor(Color.white).font(.custom(Global.regularFont , size: size.height*Global.midScale)).padding()
    }
    
    
    
    
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
