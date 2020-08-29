//
//  Timer.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/13/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import Foundation

struct readingTimer {
    private(set) var mainTimer: stopWatch = stopWatch()
    var isPaused: Bool = false
    
    
    //MARK: - Intents
    mutating func running(){
        if(!self.isPaused){
            self.mainTimer.seconds += 1
            if(self.mainTimer.seconds == 60){
                self.mainTimer.minutes += 1
                self.mainTimer.seconds = 0
                if(self.mainTimer.minutes == 60){
                    self.mainTimer.hours += 1
                    self.mainTimer.minutes = 0
                }
            
            }
        }
    }
    
    mutating func toggle(){
        self.isPaused = !self.isPaused
    }
    
    mutating func reset(){
        self.isPaused = true
        self.mainTimer.seconds = 0
        self.mainTimer.minutes = 0
        self.mainTimer.hours = 0
    }
    
    
    
}


struct stopWatch {
    var minutes: Int = 0
    var seconds: Int = 0
    var hours: Int = 0
    
}
