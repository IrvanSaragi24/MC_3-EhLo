//
//  LobbyViewModel.swift
//  MC_3
//
//  Created by Hanifah BN on 25/07/23.
//

import Foundation

class LobbyViewModel: ObservableObject {
    @Published var lobby = Lobby(name: "", silentDuration: 30, numberOfQuestion: 1)
    
    private var timer: Timer?
    private var startTime: Date?
    
    var formattedElapsedTime: String {
        let elapsedTime = lobby.elapsedTime
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimer() {
        if !lobby.isTimerRunning {
            lobby.isTimerRunning = true
            startTime = Date()
            
            // Schedule a timer to update the elapsed time every 0.1 seconds
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
                self?.updateElapsedTime()
            }
        }
    }
    
    func stopTimer() {
        if lobby.isTimerRunning {
            timer?.invalidate()
            timer = nil
            lobby.isTimerRunning = false
            lobby.elapsedTime = 0
        }
    }
    
    func pauseTimer() {
        if lobby.isTimerRunning {
            timer?.invalidate()
            timer = nil
            if let startTime = startTime {
                lobby.elapsedTime += Date().timeIntervalSince(startTime)
            }
            lobby.isTimerRunning = false
        }
    }
    
    private func updateElapsedTime() {
        if let startTime = startTime {
            lobby.elapsedTime = Date().timeIntervalSince(startTime)
        }
    }
}