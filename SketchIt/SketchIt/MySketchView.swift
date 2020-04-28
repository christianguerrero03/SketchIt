//
//  MySketchView.swift
//  SketchItBeta
//
//  Created by Christian Guerrero on 2/20/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import SwiftUI

struct MySketchView: View {
    @EnvironmentObject var userData: UserData
    var sampleSketches: [Sketch] = [sampleSketch]
    
    var body: some View {
        List {
            ForEach(userData.sketches) { sketch in
                NavigationLink(destination: SketchDetail(sketch: sketch)
                    .navigationBarTitle(Text(""), displayMode: .inline)
                ){
                    SketchCardView(sketch: sketch)
                }
            }
        }
        .navigationBarTitle(Text("My Sketches"))
    }
}

struct MySketchView_Previews: PreviewProvider {
    static var previews: some View {
        MySketchView()
        .environmentObject(UserData())
    }
}
