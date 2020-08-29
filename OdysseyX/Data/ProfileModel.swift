//
//  Profile.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/22/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import Foundation

struct ProfileModel{
    private(set) var name: String = "Nnamdi"
    private(set) var image: String = "alice"
    private(set) var equippedCharacter: Character = Character.alice
    private(set) var ownedAvatars: [Character] = [Character.alice]
    
    private(set) var bookList: Array<String> = []
    private(set) var currency: Int = 0
    private(set) var totalTime: (min:Int, sec:Int) = (0,0)
 
    mutating func changeAvatar(_ character: Character){
        self.equippedCharacter = character
    }
    
    mutating func addCurrency(of gain:Int){
        self.currency += gain

    }

    mutating func addBook(_ book:String){
        if (!bookList.contains(book)){
            bookList.append(book)
        }
        
    }
    
    mutating func addTime(_ min:Int, _ sec:Int){
        var totalSeconds = self.totalTime.sec + sec
        var totalMinutes = self.totalTime.min + min
        
        totalMinutes += totalSeconds/60
        totalSeconds = totalSeconds%60
        
        self.totalTime.min = totalMinutes
        self.totalTime.sec = totalSeconds
    
    }
    
    mutating func buyAvatar(_ character: Character){
        if self.currency >= character.price{
            self.currency -= character.price
            ownedAvatars.append(character)
        }
        else{
            print("not enough money")
        }
    }
    
}

struct Avatar{
    var id = UUID()
    var name: String
    
}
