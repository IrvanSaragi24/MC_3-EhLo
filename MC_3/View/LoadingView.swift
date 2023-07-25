//
//  LoadingView.swift
//  MC_3
//
//  Created by Irvan P. Saragi on 22/07/23.
//

import SwiftUI

struct LoadingView: View {
    @State private var IsWaiting : Bool = false
    @State var textWait : String
    
    var body: some View {
     
        ZStack{
            Color.clear.backgroundStyle()
           
                
            Circle()
            .foregroundColor(Color("Main"))
            .frame(width: 301, height: 301)
            .opacity(0.3)
            .offset(x: 130, y: -200)
            Circle()
            .foregroundColor(Color("Main"))
            .frame(width: 569)
            .opacity(0.3)
            .offset(x: -130, y: 250)
            VStack(spacing : 100){
                ZStack{
                    
                    Circle()
                        .stroke(Color("Second"), lineWidth : 40)
                        .frame(width: 166)
                        .opacity(0.4)
                    Circle()
                        .trim(from: 0.4, to: 0.8)
                        .stroke( Color("Second"), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 166)
                        .rotationEffect(Angle(degrees: IsWaiting ? 0 : -360))
                        .animation(Animation.linear(duration: 2)
                        .repeatForever(autoreverses: false))
                }
                
                Text(textWait)
                    .foregroundColor(Color("Second"))
                    .font(.system(size: 24, weight: .medium))
            }
            .padding(.top, 50)
        }
        .onAppear{
            IsWaiting = true
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(textWait: "")
    }
}
