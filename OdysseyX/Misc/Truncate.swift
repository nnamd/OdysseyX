//
//  Truncate.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 8/1/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import SwiftUI

extension CGFloat{
    
    func truncate(places: Int) -> CGFloat{
        
        return CGFloat(floor(pow(10.0, CGFloat(places)) * CGFloat(self))/pow(10.0,CGFloat(places)))
        
    }
    
    
    
    
}
extension Double{
    
    func truncate(places: Int) -> Double{
        
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0,Double(places)))
        
    }
    
    
    
    
}
