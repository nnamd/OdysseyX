//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Silas Nwagwu on 7/10/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import Foundation


extension Array where Element: Identifiable{
    func containsID(matching: Element) -> Bool{
        for index in 0..<self.count{
            if self[index].id == matching.id{
                return true
            }
        }
         return false //TODO: Bogus!
    }
            
    
}
    
