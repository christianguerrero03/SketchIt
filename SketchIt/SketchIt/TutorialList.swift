//
//  TutorialList.swift
//  SketchingAlpha
//
//  Created by Christian Guerrero on 1/25/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import SwiftUI

struct TutorialList: View {
//    @FetchRequest(
//        entity: User.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \User.favorites, ascending: false)
//        ]
//    ) var users: FetchedResults<User>
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var userData: UserData
    @Binding var user: User
    var sampleTutorials: [Tutorial] = [sample]
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $userData.showFavoritesOnly) {
                    Text("My Favorites")
                }
                ForEach(tutorialData?.items ?? sampleTutorials) { tutorial in
                    if (!self.userData.showFavoritesOnly || self.user.favorites?[tutorial._id.videoId!] ?? false) {
                        NavigationLink(destination: TutorialDetail(tutorial: tutorial, user: self.$user)
                            .navigationBarTitle(Text(""), displayMode: .inline)
                        ){
                            CardView(tutorial: tutorial, user: self.$user, isFav: self.user.favorites?[tutorial._id.videoId!] ?? false)
                        }
                    }
                }
            }
            .navigationBarTitle("Tutorials")
            .onAppear {
                print("TutorialList.onAppear()")
//                self.getUser()
            }
        }
    }
    
//    func getUser(){
//        print("TutorialList: getUser()")
//        self.user = self.users.first!
//    }
}

struct TutorialList_Previews: PreviewProvider {
    
    static var previews: some View {
        Text("Tutorial List")
//        TutorialList(user: $user)
//            .environmentObject(UserData())
    }
}
