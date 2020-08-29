//
//  StoreController.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/26/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import Foundation

class StoreController: ObservableObject{
    
    @Published var avatarShop: Store = Store()
    
    func currentCharacter() -> Character{
        
        return avatarShop.currentCharacter
    }
    
    
    func nextCharacter(){
        avatarShop.nextCharacter()
    }
    
    func prevCharacter(){
        avatarShop.prevCharacter()
    }
    
    func currentName()->String{
        return avatarShop.name()
    }
    func currentDescription()->String{
        return avatarShop.description()
    }
    func currentPrice()->Int{
        return avatarShop.price()
    }
    func currentTimeRemaining()->String{
        return avatarShop.timeRemaining()
    }
    func currentNickName()->String{
        return avatarShop.nickname()
    }
    
    
    
    
    
    
    
    
    
    
}
