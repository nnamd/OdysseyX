//
//  viewModelTimer.swift
//  Odyssey
//
//  Created by Silas Nwagwu on 7/13/20.
//  Copyright © 2020 Nnamdi Nwagwu. All rights reserved.
//

import SwiftUI

class viewModelTimer: ObservableObject{
    
    @Published private var timerModel: readingTimer = readingTimer()
    
    var oneSecondChecker:Timer?
    
    init() {
        start()
    }
    
    
    //MARK: - Access to the Model
    
    // begin timer -  remember to fix 
    func start(){
        self.oneSecondChecker = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){_ in
            DispatchQueue.main.async {
                self.timerModel.running()
            }
        }
    }

    // return minutes elapsed
    func getMinutes()->Int{
        return timerModel.mainTimer.minutes
    }
    
    // return seconds elapsed
    func getSeconds()->Int{
        return timerModel.mainTimer.seconds
    }
    
    //return time in 00:00 format
    func displayTime()->String{
        var output: String?
        let time = (sec:timerModel.mainTimer.seconds,min: timerModel.mainTimer.minutes)
        switch time {
        case let (sec,min) where sec>9:
            output = "\(min):\(sec)"
        default:
            output = "\(time.min):0\(time.sec)"
         }
        return output!
    }
    
    
    
    // toggle timer on/off
    func stop(){
        if(self.oneSecondChecker == nil){
            start()
        }
        else{
            self.oneSecondChecker?.invalidate()
            self.oneSecondChecker = nil
    }
}
    
    // reset timer to 00:00
    func reset(){
        timerModel.reset()
    }
    
    func currencyForTime()-> Int{
        return timerModel.mainTimer.minutes*100 + timerModel.mainTimer.seconds*500
    }
    
    
}
