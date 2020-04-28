//
//  CaptureView.swift
//  SketchingAlpha
//
//  Created by Christian Guerrero on 2/7/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import SwiftUI

struct CaptureView: View {
    @FetchRequest(
        entity: Sketch.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Sketch.date, ascending: true),
        ]
    ) var sketches: FetchedResults<Sketch>
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var userData: UserData
    @State private var action: Int? = 0
    @State var showCaptureImageView: Bool = false
    @State var showShareButton: Bool = false
    @State var image: Image? = nil
    @State var uiImage: UIImage? = nil
    @State var source: String = ""
    @State var title: String = ""
    @State var count: Int = 0
//    @State private var newSketch: Sketch = Sketch( Sketch(id: 0, uiImage: UIImage(named: "noimage")!, title: "Sketch 0", date: Date(), tutorial: sample)
    @State var newSketch: Sketch = Sketch()
    
    var body: some View {
        
            ZStack {
                if(!showCaptureImageView) {
                    NavigationView {
                        VStack {
                            NavigationLink(destination: SketchDetail(sketch: self.newSketch).onDisappear() {
                                    print("SketchDetail: onDisappear()")
//                                self.newSketch = Sketch(id: self.userData.sketches.count, image: Image("noimage"), title: "Sketch " + String(self.userData.sketches.count), date: Date(), tutorial: sample)
                                }
                            , tag: 1, selection: $action) {
                                EmptyView()
                            }
                            if (!showShareButton) {
                                VStack{
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(Color(red: 0.0, green: 131/255, blue: 1.0))
                                    Button(action: {
                                            self.source = "camera"
                                            self.showCaptureImageView.toggle()
                                        }) {
                                            Text("Take photo")
                                                .fontWeight(.semibold)
                                        }
                                            .frame(width: 200, height: 50, alignment: .center)
                                            .background(Color(red: 0/255, green: 131/255, blue: 255/255, opacity: 1.0).cornerRadius(12))
                                            .foregroundColor(.white)
                                            .padding()
                                            .padding(.bottom)
                                    Image(systemName: "folder.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(Color(red: 0.0, green: 131/255, blue: 1.0))
                                    Button(action: {
                                        self.source = ""
                                        self.showCaptureImageView.toggle()
                                    }) {
                                        Text("Choose photo")
                                            .fontWeight(.semibold)
                                    }
                                        .frame(width: 200, height: 50, alignment: .center)
                                        .cornerRadius(10)
                                        .background(Color(red: 0/255, green: 131/255, blue: 255/255, opacity: 1.0).cornerRadius(12))
                                        .foregroundColor(.white)
                                        .padding()
                                }.onAppear(){
                                    print("CaptureView: share: onAppear()")
                                }
                            }
                            if (showShareButton) {
                                    VStack {
                                        image?
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 200)
                                        VStack(alignment: .leading) {
                                            Text("Title").fontWeight(.semibold)
                                                .padding(.top)
                                            TextField("Title", text: $title)
                                            .padding()
                                            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                            .cornerRadius(5.0)
                                        }.padding()
                                        Button(action: {
//                                            let id = self.userData.sketches.count
//                                            self.newSketch = Sketch(id: id, uiImage: self.uiImage ?? UIImage(named:"noimage")!, title: self.title, date: Date(), tutorial: sample)
//                                            self.userData.sketches.append(self.newSketch)
                                            
                                            self.newSketch = Sketch(context: self.managedObjectContext)
                                            self.newSketch.id = Int32(self.sketches.count)
                                            self.newSketch.title = self.title
                                            self.newSketch.uiImage = self.uiImage?.jpegData(compressionQuality: 1.0)
                                            self.newSketch.date = Date()
                                            
                                            do {
                                                try self.managedObjectContext.save()
                                            } catch {
                                                print("CaptureView: CoreData error")
                                                // handle the Core Data error
                                            }
                                            self.count += 1
                                            self.title = "Sketch " + String(self.count + 1)
                                            self.showShareButton = false
                                            self.action = 1
                                        }) {
                                            Text("Add to My Sketches")
                                                .fontWeight(.semibold)
                                        }
                                            .frame(width: 200, height: 50, alignment: .center)
                                            .cornerRadius(10)
                                            .background(Color(red: 0/255, green: 131/255, blue: 255/255, opacity: 1.0).cornerRadius(12))
                                            .foregroundColor(.white)
                                            .padding()
                                        Button(action: {
                                            self.showShareButton.toggle()
                                        }) {
                                            Text("Cancel")
                                                .fontWeight(.semibold)
                                        }
                                            .frame(width: 200, height: 50, alignment: .center)
                                            .cornerRadius(10)
                                            .background(Color(red: 0/255, green: 131/255, blue: 255/255, opacity: 1.0).cornerRadius(12))
                                            .foregroundColor(.white)
                                            .padding()
                                    }.onDisappear {
                                        print("CaptureView: addSketch: onDisappear()")
                                }
                            }
                        }.navigationBarTitle("Capture")
                    }
//                    .sheet(isPresented: $showCaptureImageView) {
//                        
//                    }
                } else {
                    CameraView(isShown: self.$showCaptureImageView, image: self.$image, uiImage: self.$uiImage, share:self.$showShareButton, source: self.source)
                }
            }.onAppear() {
//                self.newSketch = Sketch(id: self.userData.sketches.count, image: Image("noimage"), title: "Sketch " + String(self.userData.sketches.count), date: Date(), tutorial: sample)
                self.count = self.sketches.count
                self.title = "Sketch " + String(self.count + 1)
            }
        }

}

struct CaptureView_Previews: PreviewProvider {
    var sketches: [Sketch] = []
    
    static var previews: some View {
        Text("CaptureView")
//        CaptureView()
    }
}
