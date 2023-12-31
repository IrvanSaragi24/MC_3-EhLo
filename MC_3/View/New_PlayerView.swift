//
//  New_PlayerView.swift
//  MC_3
//
//  Created by Sayed Zulfikar on 30/07/23.
//

import SwiftUI

struct New_PlayerView: View {
    @StateObject var synthesizerViewModel = SynthesizerViewModel()
    @EnvironmentObject var lobbyViewModel: LobbyViewModel
    @EnvironmentObject private var multipeerController: MultipeerController
    
    @State var colors: [Color] = [.clear, .clear, Color("Second"), .red]
    @State private var AnswerNo : Bool = false
    @State private var dots: String = ""
    private let dotCount = 3
    private let dotDelay = 0.5
    
    @State var isWin = true
    
    var body: some View {
        ZStack{
            BubbleView()
            GifImage("Hmm")
               .frame(width: 450, height: 450)
               .padding(.bottom, 170)
            VStack(spacing : 10) {
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 170, height: 60)
                        .foregroundColor(Color("Second"))
                        .overlay {
                            Text("\(multipeerController.myPeerId.displayName)")
                                .frame(width: 170, height: 60)
                                .font(.system(size: 24, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(Color("Background"))
                                .multilineTextAlignment(.center)
                        }
                    Capsule()
                        .stroke(Color("Second"), lineWidth: 3)
                        .frame(width: 58, height: 14)
                        .overlay {
                            Capsule()
                                .foregroundColor(Color("Background"))
                            Text("PLAYER")
                                .foregroundColor(Color("Second"))
                                .font(.system(size: 10, design: .rounded))
                                .fontWeight(.bold)
                            
                        }
                        .padding(.bottom, 55)
                }
                .padding(.bottom, 250)
                
                Text("Wait for referees to vote \nVoting : \(multipeerController.totalVote)/\(multipeerController.getConnectedPeers().count)\(dots)")
                    .font(.system(size: 28, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Second"))
                    .multilineTextAlignment(.center)
                    .onAppear {
                        animateDots()
                    }
                    .onChange(of: multipeerController.totalVote) { newValue in
                        if newValue == multipeerController.getConnectedPeers().count {
                            let result = multipeerController.yesVote >= multipeerController.noVote ? true : false
                            
                            isWin = result
                            
                            if isWin {
                                multipeerController.sendMessage(MsgCommandConstant.updateIsWinTrue, to: multipeerController.getConnectedPeers())
                            }
                            else {
                                multipeerController.sendMessage(MsgCommandConstant.updateIsWinFalse, to: multipeerController.getConnectedPeers())
                            }
                            
                            multipeerController.isWin = isWin
                            
                            multipeerController.sendMessage(NavigateCommandConstant.navigateToResult, to: multipeerController.getConnectedPeers())
                            
                            multipeerController.navigateToResult = true
                        }
                    }
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 290, height: 168)
                        .foregroundColor(Color("Second"))
                        .overlay {
                            Text(multipeerController.receivedQuestion)
                                .font(.system(size: 17, design: .rounded))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    Capsule()
                        .stroke(Color("Second"), lineWidth: 3)
                        .frame(width: 120, height: 28)
                        .overlay {
                            Capsule()
                                .foregroundColor(Color("Background"))
                            Text("Question")
                                .foregroundColor(Color("Second"))
                                .font(.system(size: 12, design: .rounded))
                                .fontWeight(.bold)
                        }
                        .padding(.bottom, 160)
                    Circle()
                        .stroke(Color("Second"), lineWidth : 4)
                        .frame(width: 60)
                        .overlay{
                            Circle()
                                .frame(width: 60)
                                .foregroundColor(Color("Background"))
                            Text("\(multipeerController.currentQuestion) / \(multipeerController.totalQuestion)")
                                .font(.system(size: 16, design: .rounded))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Second"))
                            
                        }
                        .padding(.top, 170)
                    
                }
                
                
                Button {
                    synthesizerViewModel.startSpeaking(spokenString: multipeerController.receivedQuestion)
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 76, height: 30)
                            .foregroundColor(Color("Main"))
                        Image(systemName: "speaker.wave.3.fill")
                            .resizable()
                            .frame(width: 22, height: 16)
                            .foregroundColor(Color("Second"))
                    }
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(
            NavigationLink(
                destination: New_ResultView()
                    .environmentObject(multipeerController)
                    .environmentObject(lobbyViewModel),
                isActive: $multipeerController.navigateToResult
            ) {
                EmptyView()
            }
        )
        .onAppear() {
            multipeerController.resetNavigateVar()
        }
        .onDisappear{
            synthesizerViewModel.stopSpeaking()
        }
        .task {
            synthesizerViewModel.startSpeaking(spokenString: multipeerController.receivedQuestion)
        }
        
    }
    
    func animateDots() {
        var count = 0
        dots = ""
        
        func addDot() {
            dots += "."
            count += 1
            if count <= dotCount {
                DispatchQueue.main.asyncAfter(deadline: .now() + dotDelay) {
                    addDot()
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + dotDelay) {
                    animateDots() // Start the animation again
                }
            }
        }
        
        addDot()
    }
}

struct New_PlayerView_Previews: PreviewProvider {
    
    @StateObject var synthesizerViewModel = SynthesizerViewModel()
    
    static var previews: some View {
        New_PlayerView()
            .environmentObject(MultipeerController("YourDisplayName"))
            .environmentObject(LobbyViewModel())
    }
}

