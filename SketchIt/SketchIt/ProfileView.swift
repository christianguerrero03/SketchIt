//
//  ProfileView.swift
//  SketchingAlpha
//
//  Created by Christian Guerrero on 1/30/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import SwiftUI
import CoreData

struct ProfileView: View {
    @FetchRequest(
        entity: Sketch.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Sketch.date, ascending: true),
        ]
    ) var sketches: FetchedResults<Sketch>
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \User.firstName, ascending: true),
            NSSortDescriptor(keyPath: \User.lastName, ascending: false),
            NSSortDescriptor(keyPath: \User.email, ascending: false),
            NSSortDescriptor(keyPath: \User.pic, ascending: false)
        ]
    ) var users: FetchedResults<User>
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var userData: UserData
    @State var showCaptureImageView: Bool = false
    @State var showShareButton: Bool = false
    @State var uiImage: UIImage? = nil
    @State var newUIImage: UIImage? = nil
    @State var newImage: Image? = nil
    @State var source: String = ""
    @State var edit: Bool = false
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var user: User?
    @State var mySketches: [Sketch] = [sampleSketch]
    
    var body: some View {
        ZStack {
            NavigationView{
                if (!self.edit) {
                    List {
                        HStack {
                            VStack {
                                CircleImage(image: Image(uiImage: uiImage ?? UIImage(named: "user")!).resizable())
                                    .frame(width: 100, height: 100, alignment: .leading)
                            }.padding(.leading)
                            Spacer()
                            VStack(alignment: .leading, spacing: 5) {
                                if (self.firstName == ""){
                                    Text("Welcome!")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 25))
                                } else {
                                    Text((self.user?.firstName ?? "") + " " + (self.user?.lastName ?? ""))
                                    .fontWeight(.semibold)
                                    .font(.system(size: 25))
                                }
                                Button(action: {
                                    self.edit = true
                                }){
                                    HStack {
                                        Text("Edit Profile")
                                            .foregroundColor(.blue)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                }
                            }.padding()
                            Spacer()
                        }
                        .padding([.top, .bottom])
                        ForEach(self.sketches.reversed(), id: \.id) { sketch in
                            NavigationLink(destination: SketchDetail(sketch: sketch)
                                .navigationBarTitle(Text(""), displayMode: .inline)
                            ){
                                SketchCardView(sketch: sketch)
                            }
                        }.onDelete(perform: removeSketches)
                    }
                    .navigationBarTitle(Text("My Sketches"))
                }
                else {
                    VStack {
                        HStack {
                            VStack {
                                Button(action: {
                                    self.showCaptureImageView = true
                                }){
                                    CircleImage(image: Image(uiImage: uiImage ?? UIImage(named: "user")!).resizable())
                                    .frame(width: 100, height: 100, alignment: .leading)
                                }
                            }.padding(.leading)
                            //Spacer()
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Profile Picture")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 25))
                            }.padding()
                            Spacer()
                        }
                        .padding([.top, .bottom])
                        VStack(alignment: .leading) {
                            Text("Your Info").fontWeight(.semibold)
                                .padding(.top)
                            TextField("First Name", text: $firstName)
                                .padding()
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                .cornerRadius(5.0)
                            TextField("Last Name", text: $lastName)
                                .padding()
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                .cornerRadius(5.0)
                            TextField("Email", text: $email)
                                .padding()
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                .cornerRadius(5.0)
                        }.padding()
                        Button(action: {
                            self.user?.firstName = self.firstName
                            self.user?.lastName = self.lastName
                            self.user?.email = self.email
                            self.user?.pic = self.uiImage!.pngData()
                            if self.managedObjectContext.hasChanges {
                                do {
                                    try self.managedObjectContext.save()
                                } catch {
                                    // handle the Core Data error
                                }
                            }
                            self.edit = false
                        }) {
                            Text("Update")
                                .fontWeight(.semibold)
                        }
                            .frame(width: 200, height: 50, alignment: .center)
                            .background(Color(red: 0/255, green: 131/255, blue: 255/255, opacity: 1.0).cornerRadius(12))
                            .foregroundColor(.white)
                            .padding()
                        Button(action: {
                            self.edit = false
                        }) {
                            Text("Cancel")
                                .fontWeight(.semibold)
                        }
                            .frame(width: 200, height: 50, alignment: .center)
                            .background(Color(red: 0/255, green: 131/255, blue: 255/255, opacity: 1.0).cornerRadius(12))
                            .foregroundColor(.white)
                            .padding()

                    }.navigationBarTitle(Text("Edit Profile"))
                    .sheet(isPresented: $showCaptureImageView) {
                        CameraView(isShown: self.$showCaptureImageView, image: self.$newImage, uiImage: self.$uiImage, share:self.$showShareButton, source: self.source).onDisappear {
//                            if (nil != self.newImage) {
//                                self.image = self.newImage
//                            }
                        }
                    }
                }
            }.onAppear {
                self.getUser()
                self.getSketches()
            }
            
        }
    }
    
    func getUser(){
        self.user = self.users.first
        self.firstName = self.user?.firstName ?? "Welcome!"
        self.lastName = self.user?.lastName ?? ""
        self.email = self.user?.email ?? ""
        if (nil != self.user) {
            self.uiImage = UIImage(data: (self.user?.pic)!)
        }
    }
    
    func removeSketches(at offsets: IndexSet) {
        for index in offsets {
            let sketch = sketches[sketches.count - 1 - index]
            managedObjectContext.delete(sketch)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("Core Data error")
            // handle the Core Data error
        }
    }
    
    func getSketches(){
//        self.mySketches = self.sketches.reversed()
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
        .environmentObject(UserData())
    }
}
