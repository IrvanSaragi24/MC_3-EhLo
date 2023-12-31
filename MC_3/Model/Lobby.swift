//
//  Lobby.swift
//  MC_3
//
//  Created by Sayed Zulfikar on 18/07/23.
//

import Foundation

struct Lobby: Identifiable {
    let id = UUID()
    var name: String
    var silentDuration: Int
    var numberOfQuestion: Int
    var question: String?
    var elapsedTime: TimeInterval = 0
    var isTimerRunning = false
    var currentQuestionIndex: Int = 1
    
    init(name: String, silentDuration: Int, numberOfQuestion: Int) {
        self.name = name
        self.silentDuration = silentDuration
        self.numberOfQuestion = numberOfQuestion
    }
    
    init(name: String) {
        self.init(name: name, silentDuration: 10, numberOfQuestion: 1)
    }
}
