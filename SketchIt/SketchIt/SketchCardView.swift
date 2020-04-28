//
//  SketchCardView.swift
//  SketchingAlpha
//
//  Created by Christian Guerrero on 1/30/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct SketchCardView: View {
    @EnvironmentObject var userData: UserData
    var sketch: Sketch
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: sketch.uiImage!)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Sketch")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .fontWeight(.black)
                        Spacer()
                    }
                    Text(sketch.title!)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .lineLimit(3)
                        .shadow(radius: 5)

                    Text(sketch.date!.string(format: "MM/dd/yyyy"))
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
    }
    
}

struct SketchCardView_Previews: PreviewProvider {
    static var previews: some View {
        SketchCardView(sketch: sampleSketch)
    }
}
