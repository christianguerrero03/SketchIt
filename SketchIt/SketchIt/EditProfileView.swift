//
//  EditProfileView.swift
//  SketchItBeta
//
//  Created by Christian Guerrero on 2/25/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import SwiftUI

struct EditProfileView: View {
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \User.firstName, ascending: true),
            NSSortDescriptor(keyPath: \User.lastName, ascending: false),
            NSSortDescriptor(keyPath: \User.email, ascending: false)
        ]
    ) var users: FetchedResults<User>
    @Environment(\.managedObjectContext) var managedObjectContext
    //@EnvironmentObject var userData: UserData
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var user: User?
    
    var body: some View {
        VStack {
//            HStack {
//                VStack {
//                    CircleImage(image:Image("profile").resizable())
//                        .frame(width: 100, height: 100, alignment: .leading)
//                }.padding(.leading)
//                Spacer()
//            }

            Form {
                Section(header: Text("Your Info").fontWeight(.semibold)) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Email", text: $email)
                }
                Section {
                    Button(action: {
                        self.user?.firstName = self.firstName
                        self.user?.lastName = self.lastName
                        self.user?.email = self.email
                        if self.managedObjectContext.hasChanges {
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                // handle the Core Data error
                            }
                        }
                    }) {
                        Text("Update")
                            .fontWeight(.semibold)
                    }
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color(red: 0/255, green: 131/255, blue: 255/255, opacity: 1.0).cornerRadius(12))
                        .foregroundColor(.white)
                        .padding()
                    Button(action: {
                        //self.edit = false
                    }) {
                        Text("Cancel")
                            .fontWeight(.semibold)
                    }
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color(red: 0/255, green: 131/255, blue: 255/255, opacity: 1.0).cornerRadius(12))
                        .foregroundColor(.white)
                        .padding()
//                    Button(action: {
//                        self.user?.firstName = self.firstName
//                        self.user?.lastName = self.lastName
//                        self.user?.email = self.email
//                        if self.managedObjectContext.hasChanges {
//                            do {
//                                try self.managedObjectContext.save()
//                            } catch {
//                                // handle the Core Data error
//                            }
//                        }
//                        //self.onDisappear()
//                    }) {
//                        Text("Submit")
//                    }
//                    Button(action: {
//                        //self.onDisappear()
//                    }) {
//                        Text("Cancel")
//                    }.foregroundColor(Color.red)
                }
            }
            .navigationBarTitle(Text("Edit Profile"))
        }.onAppear {
            self.getUser()
        }
    }
    
    func getUser(){
        self.user = self.users.first
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
