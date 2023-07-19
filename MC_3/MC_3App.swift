//
//  MC_3App.swift
//  MC_3
//
//  Created by Irvan P. Saragi on 14/07/23.
//

import SwiftUI

@main
struct MC_3App: App {
    @StateObject private var connectionManager = ConnectionManager()
    var body: some Scene {
        WindowGroup {
//            ContentView()
            ChooseRoleView()
                .environmentObject(connectionManager)
        }
    }
}