//
//  TitleFade.swift
//  SketchingAlpha
//
//  Created by Christian Guerrero on 1/25/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import SwiftUI

struct TitleFade: View {
    @State private var half = true
    @State private var dim = true
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(red: 0/255, green: 131/255, blue: 255/255, opacity: 1.0)
                .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Welcome")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .scaleEffect(half ? 0.75 : 1.0)
                        .opacity(dim ? 0.0 : 1.0)
                        .animation(.easeInOut(duration: 2.0))
                    NavigationLink(destination: TutorialList().environmentObject(UserData())){
                        Text("Get Started")
                        .scaleEffect(half ? 0.75 : 1.0)
                        .opacity(dim ? 0.0 : 1.0)
                        .animation(Animation.easeInOut(duration: 2.0).delay(2.0))
                    }
                    
                }
                .foregroundColor(Color.white)
                .onAppear {
                    self.dim.toggle()
                    self.half.toggle()
                }
            }
            
        }
    }
//    var body: some View {
//        Text("Welcome")
//        .font(.largeTitle)
//        .fontWeight(.semibold)
//        .foregroundColor(Color.white)
//    }
}

struct TitleFade_Previews: PreviewProvider {
    static var previews: some View {
        TitleFade()
            .background(Color.black)
            .environmentObject(UserData())
    }
}
