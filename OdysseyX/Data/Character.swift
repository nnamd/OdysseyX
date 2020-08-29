//
//  Character.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/29/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import Foundation

struct Character : Identifiable{
    var id = UUID()
    var name: String
    var nickname: String
    var description: String
    var price: Int
    var timeRemaining: String
    var story: String = "placeholder"
}


extension Character{
    
    static let alice: Character = Character(name:"Alice",nickname: "alice", description: "from Alice's Adventures in Wonderland", price: 500, timeRemaining: "2d 12h", story: " The rabbit-hole went straight on like a tunnel for some way, and then dipped suddenly down, so suddenly that Alice had not a moment to think about stopping herself before she found herself falling down a very deep well.Either the well was very deep, or she fell very slowly, for she had plenty of time as she went down to look about her and to wonder what was going to happen next. First, she tried to look down and make out what she was coming to, but it was too dark to see anything; then she looked at the sides of the well, and noticed that they were filled with cupboards and book-shelves; here and there she saw maps and pictures hung upon pegs. She took down a jar from one of the shelves as she passed; it was labelled `ORANGE MARMALADE', but to her great disappointment it was empty: she did not like to drop the jar for fear of killing somebody, so managed to put it into one of the cupboards as she fell past it.")
    static let monster: Character = Character(name: "The Monster",nickname: "monster", description: "from Mary Shelley's Frankenstein", price: 250, timeRemaining: "3d 5h", story: "placeholder")
    static let sherlock: Character = Character(name: "Sherlock Holmes",nickname: "sherlock", description: "the famous detective himself", price: 750, timeRemaining: "1d 1h", story: "Dark and mysterious past.")
    static let scarlett: Character = Character(name: "Scarlett O'Hara",nickname: "scarlett", description: "from Gone With The Wind", price: 800, timeRemaining: "6d 9h", story: "Not to be confused with Spongebob Squarepants.")
    static let invisman = Character(name: "The Invisible Man", nickname: "invisman", description: "from The Invisible Man", price: 350, timeRemaining: "5d 4d",story: "?????? There's nothing here lol")
    
    
    
    
}



