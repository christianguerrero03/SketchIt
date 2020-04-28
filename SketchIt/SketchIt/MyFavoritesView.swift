//
//  MyFavoritesView.swift
//  SketchItBeta
//
//  Created by Christian Guerrero on 2/25/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import SwiftUI

struct MyFavoritesView: View {
    @EnvironmentObject var userData: UserData
    @State var showNav = true
    var sampleTutorials: [Tutorial] = [sample]
    
    var body: some View {
        //NavigationView {
            List {
                ForEach(tutorialData?.items ?? sampleTutorials) { tutorial in
                    if ( self.userData.favorites[tutorial._id.videoId!]!) {
                        NavigationLink(destination: TutorialDetail(tutorial: tutorial)
                            .navigationBarTitle(Text(""), displayMode: .inline)
                        ){
                            CardView(tutorial: tutorial, isFav: true)
                        }
                    }
                }
            }
            .navigationBarTitle("My Favorites")
            //.navigationBarHidden(true)
        //}
    }
}

struct MyFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        MyFavoritesView()
    }
}
