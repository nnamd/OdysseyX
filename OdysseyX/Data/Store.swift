//
//  Store.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/26/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import Foundation


struct Store{
    
    private(set) var store: [Character] = []
    private(set) var currentCharacter: Character
    private(set) var characterValue: Int = 0
    
    

    
    init(){
        store.append(Character.alice)
        store.append(Character.monster)
        store.append(Character.sherlock)
        store.append(Character.scarlett)
        store.append(Character.invisman)
        
        currentCharacter = store[characterValue]
    }
    
    //increments character in list
    mutating func nextCharacter(){
        if characterValue == store.count-1{
            characterValue = 0
        }
        else{
        characterValue += 1
        }
        currentCharacter = store[characterValue]
    }
    
    //decrements character in list
    mutating func prevCharacter(){
        if characterValue == 0{
            characterValue = store.count-1
        }
        else{
        characterValue -= 1
        }
        currentCharacter = store[characterValue]
    }
    
    //MARK: - Current Character Info
    func name()-> String{
        print("\(currentCharacter.name)")
        return currentCharacter.name
    }
    
    func description()-> String{
        return currentCharacter.description
    }
    
    func price()-> Int{
        return currentCharacter.price
    }
    
    func timeRemaining()->String{
        return currentCharacter.timeRemaining
    }
    func nickname()->String{
        return currentCharacter.nickname
    }
    
    
    
    
    
}

