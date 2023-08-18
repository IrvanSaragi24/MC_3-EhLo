//
//  TrainVoiceView.swift
//  MC_3
//
//  Created by Irvan P. Saragi on 16/07/23.
//

import SwiftUI

struct EndView: View {
    @EnvironmentObject var lobbyViewModel: LobbyViewModel
    @EnvironmentObject private var multipeerController: MultipeerController
    @EnvironmentObject private var playerData: PlayerData
    
    var body: some View {
        ZStack {
            BubbleView()
            VStack(spacing : 16) {
                Text("CONTINUE\nHANGOUT?")
                    .font(.system(size: 40, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Second"))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 100)

                if multipeerController.isPlayer {
                    Button {
                        let connectedGuest = multipeerController.getConnectedPeers()
                        //reset setting
                        multipeerController.sendMessage(NavigateCommandConstant.navigateToListen, to: connectedGuest)
                        
                        multipeerController.resetParameters(page: NavigateCommandConstant.navigateToListen
                        )
                        multipeerController.navigateToListen = true

                        print("Continue Listening")
                    } label: {
                    Text("Continue")
                        .font(.system(size: 28, design: .rounded))
                        .fontWeight(.bold)
                    }
                    .buttonStyle(MultipeerButtonStyle())
                    
                    Button {
                        // reset
                        let connectedGuest = multipeerController.getConnectedPeers()
                        multipeerController.sendMessage(NavigateCommandConstant.navigateToChooseRole, to: connectedGuest)
                        multipeerController.resetParameters(page: NavigateCommandConstant.navigateToChooseRole
                        )
                        multipeerController.navigateToChooseRole = true
                        
                    } label: {
                    Text("End Session")
                        .font(.system(size: 28, design: .rounded))
                        .fontWeight(.bold)
                    }
                    .buttonStyle(SecondButtonStyle())
                }
                else {
                    Text("Waiting for decision..")
                        .font(.system(size: 28, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Second"))
                        .multilineTextAlignment(.center)
                }
            }
            .background(
                NavigationLink(
                    destination: ListenView()
                        .environmentObject(multipeerController)
                        .environmentObject(lobbyViewModel),
                    isActive: $multipeerController.navigateToListen
                ) {
                    EmptyView()
                }
            )
        }
        .navigationBarBackButtonHidden(true)
        .background(
            NavigationLink(
                destination: ChooseRoleView()
                    .environmentObject(multipeerController)
                    .environmentObject(lobbyViewModel),
                isActive: $multipeerController.navigateToChooseRole
            ) {
                EmptyView()
            }
        )
        .onAppear() {
            multipeerController.resetNavigateVar()
        }
    }
}



struct EndView_Previews: PreviewProvider {
    
    static var previews: some View {
        EndView()
            .environmentObject(MultipeerController("YourDisplayName"))
            .environmentObject(LobbyViewModel())
    }
}
