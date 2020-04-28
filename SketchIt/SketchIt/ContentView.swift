//
//  ContentView.swift
//  SketchingAlpha
//
//  Created by Christian Guerrero on 1/25/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import SwiftUI
import Pages

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var userData: UserData
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \User.favorites, ascending: false)
        ]
    ) var users: FetchedResults<User>
    @FetchRequest(
        entity: Sketch.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Sketch.date, ascending: true),
        ]
    ) var sketches: FetchedResults<Sketch>
    @State var user: User = User()
    @State var isUser = false
    
    @State private var half = true
    @State private var dim = true
    @State var index: Int = 0
    @State var page = "welcome"
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                if self.page == "welcome" {
                    Color(red: 0/255, green: 131/255, blue: 255/255, opacity: 1.0)
                    .edgesIgnoringSafeArea(.all)
                    HStack {
                        VStack {
                            Text("      Welcome to      ")
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                                .padding(.top)
                                .scaleEffect(self.half ? 0.75 : 1.0)
                                .opacity(self.dim ? 0.0 : 1.0)
                                .animation(.easeInOut(duration: 1.5))
                                
                            Text("Sketch It")
                                .font(.system(size: 65))
                                .fontWeight(.semibold)
                                .padding(.bottom)
                                .scaleEffect(self.half ? 0.75 : 1.0)
                                .opacity(self.dim ? 0.0 : 1.0)
                                .animation(Animation.easeInOut(duration: 1.5).delay(1.0))
                    
                            Button(action: {
                                if(self.isUser){
                                    self.page = "home"
                                }
                                else {
                                   self.page = "walk"
                                }
                            }) {
                                    Text("Get Started")
                                        .fontWeight(.semibold)
                                        .scaleEffect(self.half ? 0.75 : 1.0)
                                        .opacity(self.dim ? 0.0 : 1.0)
                                        .animation(Animation.easeInOut(duration:    1.5).delay(2.0))
                            }
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .onAppear {
                            self.dim.toggle()
                            self.half.toggle()
                        }
                    }.onAppear() {
                        self.initUser()
                    }
                }
                else if self.page == "walk" {
                    Color(red: 0/255, green: 131/255, blue: 255/255, opacity: 1.0)
                    .edgesIgnoringSafeArea(.all)
                    Pages(currentPage: self.$index) {
                        VStack{
                            HStack{
                                Spacer()
                                Button(action: {
                                    self.page = "home"
                                }) {
                                    Image(systemName: "multiply")
                                        .resizable()
                                        .frame(width: 25, height: 25, alignment: .center)
                                        .padding()
                                }
                            }
                            Text("Tutorials")
                                .fontWeight(.semibold)
                                .font(.largeTitle)
                            Image("home")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .padding([.leading, .trailing, .bottom])
                            Text("Access dozens of easy sketching tutorials")
                                .fontWeight(.semibold)
                                .font(.headline)
                                //.padding()
                            Button(action: {
                                self.index = 1
                            }) {
                                Text("Next")
                                    .fontWeight(.semibold)
                            }
                                .frame(width: 200, height: 50, alignment: .center)
                                .cornerRadius(10)
                            .background(Color.white).cornerRadius(12)
                            .foregroundColor(Color.blue)
                                .padding()
                        }
                            .foregroundColor(.white)
                            .padding(.bottom, 50)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                        VStack{
                            HStack{
                                Spacer()
                                Button(action: {
                                    self.page = "home"
                                }) {
                                    Image(systemName: "multiply")
                                        .resizable()
                                        .frame(width: 25, height: 25, alignment: .center)
                                        .padding()
                                }
                            }
                            Text("My Favorites")
                                .fontWeight(.semibold)
                                .font(.largeTitle)
                            Image("favorites")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .padding([.leading, .trailing, .bottom])
                            Text("Filter out your favorite tutorials")
                                .fontWeight(.semibold)
                                .font(.headline)
                                //.padding()
                            Button(action: {
                                self.index = 2
                            }) {
                                Text("Next")
                                    .fontWeight(.semibold)
                            }
                                .frame(width: 200, height: 50, alignment: .center)
                                .cornerRadius(10)
                            .background(Color.white).cornerRadius(12)
                            .foregroundColor(Color.blue)
                                .padding()
                        }.foregroundColor(.white)
                        .padding(.bottom, 50)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                        VStack{
                            HStack{
                                Spacer()
                                Button(action: {
                                    self.page = "home"
                                }) {
                                    Image(systemName: "multiply")
                                        .resizable()
                                        .frame(width: 25, height: 25, alignment: .center)
                                        .padding()
                                }
                            }
                            Text("Capture")
                                .fontWeight(.semibold)
                                .font(.largeTitle)
                            Image("capture")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding([.leading, .trailing, .bottom])
                            Text("Capture and share your finished sketches")
                                .fontWeight(.semibold)
                                .font(.headline)
                                //.padding()
                            Button(action: {
                                self.index = 3
                            }) {
                                Text("Next")
                                    .fontWeight(.semibold)
                            }
                                .frame(width: 200, height: 50, alignment: .center)
                                .cornerRadius(10)
                            .background(Color.white).cornerRadius(12)
                            .foregroundColor(Color.blue)
                                .padding()
                        }.foregroundColor(.white)
                        .padding(.bottom, 50)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                        VStack{
                            HStack{
                                Spacer()
                                Button(action: {
                                    self.page = "home"
                                }) {
                                    Image(systemName: "multiply")
                                        .resizable()
                                        .frame(width: 25, height: 25, alignment: .center)
                                        .padding()
                                }
                            }
                            Text("My Sketches")
                                .fontWeight(.semibold)
                                .font(.largeTitle)
                            Image("sketches")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .padding([.leading, .trailing, .bottom])
                            Text("View your sketches and profile")
                                .fontWeight(.semibold)
                                .font(.headline)
                                //.padding()
                            Button(action: {
                                self.page = "home"
                            }) {
                                Text("Done")
                                    .fontWeight(.semibold)
                            }
                                .frame(width: 200, height: 50, alignment: .center)
                                .cornerRadius(10)
                            .background(Color.white).cornerRadius(12)
                            .foregroundColor(Color.blue)
                                .padding()
                        }.foregroundColor(.white)
                        .padding(.bottom, 50)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                    }.onDisappear() {
                        UserDefaults.standard.set(true, forKey: "isUser")
                    }
                    
                }
                else {
                    VStack {
                        TabView {
                            TutorialList(user: self.$user)
//                                .environmentObject(UserData())
                                .tabItem {
                                    Image(systemName: "pencil.tip")
                                    Text("Tutorials")
                                }.tag(1)
                            CaptureView()
//                                .environmentObject(UserData())
                                .tabItem {
                                    Image(systemName: "camera")
                                    Text("Capture")
                                }.tag(2)
                            ProfileView()
//                                .environmentObject(UserData())
                                .tabItem {
                                    Image(systemName: "person")
                                    Text("Profile")
                                }.tag(3)
                        }
                        .font(.headline)
                    }
                }
            }
        }
    }
    
    func initUser () {
        print("ContnetView: initUser()")
        self.isUser = UserDefaults.standard.bool(forKey: "isUser")
        if(!self.isUser){
            print("New User")
            self.user = User(context: self.managedObjectContext)
            user.firstName = ""
            user.lastName = ""
            user.email = ""
            user.favorites = [:]
            
            let image = UIImage(named: "user")
            user.pic = image?.pngData()
            
            do {
                try self.managedObjectContext.save()
            } catch {
                // handle the Core Data error
            }
        } else {
            print("Returning User")
            do {
                try self.user = self.users.first!
            } catch {
                print("users.first is null")
            }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone XS Max"], id: \.self) { deviceName in
            ContentView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
        .environmentObject(UserData())
    }
}
