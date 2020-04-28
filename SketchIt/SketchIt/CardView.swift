//
//  CardView.swift
//  SketchingAlpha
//
//  Created by Christian Guerrero on 1/30/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {
    @EnvironmentObject var userData: UserData
    var tutorial: Tutorial
    @Binding var user: User
    @State var isFav: Bool
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: tutorial.snippet.thumbnails.medium.url))
                .onSuccess { image, cacheType in
                    // Success
                }
                .resizable() // Resizable like SwiftUI.Image
                .placeholder(Image(systemName: "photo")) // Placeholder Image
                // Supports ViewBuilder as well
                .placeholder {
                    Rectangle().foregroundColor(Color(red: 156/255, green: 207/255, blue: 1.0, opacity: 1.0))
                }
                .indicator(.activity) // Activity Indicator
                .animation(.easeInOut(duration: 0.5)) // Animation Duration
                .transition(.fade) // Fade Transition
                .scaledToFit()
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Tutorial")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .fontWeight(.black)
                        Spacer()
                        if (isFav) {
                            Image(systemName: "star.fill")
                                .imageScale(.medium)
                                .foregroundColor(.yellow)
                        }
                    }
                    Text(tutorial.snippet.title)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .lineLimit(3)
                        .shadow(radius: 5)

                    Text("BY " + tutorial.snippet.channelTitle.uppercased())
                        .font(.caption)
                        .foregroundColor(.primary)
                        .fontWeight(.black)
                }
                .layoutPriority(100)
                Spacer()
            }
            .padding()
        }
        .background(Color(red: 0/255, green: 131/255, blue: 255/255, opacity: 1.0))
        .edgesIgnoringSafeArea(.all)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
            .onAppear {
                //print("CardView.onAppear")
                self.isFav = self.user.favorites?[self.tutorial._id.videoId!] ?? false
        }
    }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Text("CardView")
//        CardView(tutorial: sample, isFav: true)
    }
}
