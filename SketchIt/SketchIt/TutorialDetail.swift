//
//  TutorialDetail.swift
//  SketchingAlpha
//
//  Created by Christian Guerrero on 1/28/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import SwiftUI

struct TutorialDetail: View {
//    @FetchRequest(
//        entity: User.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \User.favorites, ascending: false)
//        ]
//    ) var users: FetchedResults<User>
    @Environment(\.managedObjectContext) var managedObjectContext
    //@EnvironmentObject var userData: UserData
    var tutorial: Tutorial
//    var tutorialIndex: Int {
//        (userData.tutorials?.items.firstIndex(where: { $0.id == tutorial.id}))!
//    }
    @Binding var user: User
    @State var isFav: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .top){
                    WebView(url: "https://www.youtube.com/watch?v="+tutorial._id.videoId!)
                }
//                Spacer()
            }
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Tutorial")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .fontWeight(.black)
                            Spacer()
                            Button(action: {
                                self.isFav.toggle()
                                self.user.favorites?[self.tutorial._id.videoId!] = self.isFav
                                if self.managedObjectContext.hasChanges {
                                    print("managedObjectContext.hasChanges")
                                    do {
                                        try self.managedObjectContext.save()
                                        print("managedObjectContext.save()")
                                    } catch {
                                        // handle the Core Data error
                                        print("core data error")
                                    }
                                }
                            }) {
                                //if self.user?.favorites?[tutorial._id.videoId!]! ?? false
                                if self.isFav
                                {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 25))
                                        .foregroundColor(Color.yellow)
                                } else {
                                    Image(systemName: "star")
                                        .font(.system(size: 25))
                                        .foregroundColor(Color.yellow)
                                }
                            }
                        }.padding(.top)
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
                            .padding(.top)
                            .padding(.bottom)
                        Text(tutorial.snippet.description)
                            .font(.headline)
                    }
                    .layoutPriority(100)
                    Spacer()
                }
                .padding()

            }
            .background(Color(red: 0/255, green: 131/255, blue: 255/255, opacity: 1.0)
            .edgesIgnoringSafeArea(.all))
            .foregroundColor(Color.white)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
        }.navigationBarBackButtonHidden(false)
        .onAppear {
            self.isFav = self.user.favorites?[self.tutorial._id.videoId!] ?? false
//            self.getUser()
        }.onDisappear() {
            
        }
    }
    
//    func getUser(){
//        self.user = self.users.first
//        print("getUser()")
//        if(nil == self.user?.favorites?[tutorial._id.videoId!]) {
//            print("newFav")
//            self.user?.favorites?[tutorial._id.videoId!] = false
//        } else {
//            print("oldFav")
//            self.isFav = (self.user?.favorites?[tutorial._id.videoId!])!
//        }
//    }
    
}

struct TutorialDetail_Previews: PreviewProvider {
    static var previews: some View {
        Text("TutorialDetail")
//        TutorialDetail(tutorial: sample)
//        .environmentObject(UserData())
    }
}
