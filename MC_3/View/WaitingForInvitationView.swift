//
//  WaitingForInvitationView.swift
//  MC_3
//
//  Created by Sayed Zulfikar on 28/07/23.
//

import SwiftUI

struct WaitingForInvitationView: View {
    @EnvironmentObject private var multipeerController: MultipeerController
    
    var body: some View {
        
        LoadingView(textWait: "Waiting invitation from a host...", circleSize: 166, LineWidtCircle: 40, LineWidtCircle2: 35, yOffset: 0)
            .onDisappear(){
                multipeerController.isAdvertising = false
            }
            .onAppear(){
                multipeerController.resetNavigateVar()
                multipeerController.isAdvertising = true
            }
            .background(
                NavigationLink(
                    destination: WaitingToStartView()
                        .environmentObject(multipeerController),
                    isActive: $multipeerController.navigateToWaitingStart
                ) {
                    EmptyView()
                }
            )
        
    }
}

struct WaitingForInvitationView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingForInvitationView()
            .environmentObject(MultipeerController("Player"))
    }
}
