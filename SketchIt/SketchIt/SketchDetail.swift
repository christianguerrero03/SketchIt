//
//  SketchDetailView.swift
//  SketchItBeta
//
//  Created by Christian Guerrero on 2/23/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import SwiftUI
import Social

struct SketchDetail: View {
    @State var share: Bool = false
    @State var showShareSheet: Bool = false
    var sketch: Sketch
    var sharableImage: UIImage?
    
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .top){
                    Image(uiImage: UIImage(data: sketch.uiImage!)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }

            VStack(alignment: .center) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Sketch")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .fontWeight(.black)
                        
                        HStack {
                            Text(sketch.title!)
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundColor(.white)
                                .lineLimit(3)
                                .shadow(radius: 5)
                        }
                        Text(sketch.date!.string(format: "MM/dd/yyyy"))
                            .font(.caption)
                            .foregroundColor(.primary)
                            .fontWeight(.black)
                            .padding(.top)
                            .padding(.bottom)
                    }
//                    .layoutPriority(100)
                    Spacer()
                }
                .padding()

                VStack (alignment: .center){
                    Button(action: {
                        print("Share")
                        self.showShareSheet = true
                    }) {
                        HStack{
                            Image(systemName: "square.and.arrow.up.on.square.fill")
                            .font(.system(size: 40))
                                .padding(.trailing)
                            Text("Save or Share")
                            .font(.headline)
                            .fontWeight(.black)
                        }
                    }
                        .frame(width: 250, height: 80, alignment: .center)
                            .cornerRadius(10)
                        .background(Color.white).cornerRadius(12)
                        .foregroundColor(Color.blue)
                            .padding()
                    .sheet(isPresented: $showShareSheet, onDismiss: {
                        print("Dismiss")
                    }, content: {
                        ShareSheet(activityItems: ["#SketchIt", self.sketch.uiImage
//                            .jpegData(compressionQuality: 1.0)
                        ])
                    })
//                    HStack{
//                        Image("instagram")
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                        Text("Share to Instagram")
//                    }
//                    HStack{
//                        Image("facebook")
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                        Text("Share to Facebook")
//                    }
//                    HStack{
//                        Image("twitter")
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                        Text("Share to Twitter")
//                    }
                }.padding()
                    .padding(.bottom)
                Spacer()

            }
            .background(Color(red: 0/255, green: 131/255, blue: 255/255, opacity: 1.0)
            .edgesIgnoringSafeArea(.all))
            .foregroundColor(Color.white)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
        }.navigationBarTitle(Text(""), displayMode: .inline)

    }
    
////    credit: https://www.8mincode.com/posts/how-to-share-an-image-on-instagram-with-ios-swift/
//    func shareToInstagramFeed(image: UIImage) {
//        // build the custom URL scheme
//        guard let instagramUrl = URL(string: "instagram://app") else {
//            return
//        }
//
//        // check that Instagram can be opened
//        if UIApplication.shared.canOpenURL(instagramUrl) {
//            // build the image data from the UIImage
//            guard let imageData = image.jpegData(compressionQuality: 100) else {
//                return
//            }
//
//            // build the file URL
//            let path = (NSTemporaryDirectory() as NSString).appendingPathComponent("instagram.ig")
//            let fileUrl = URL(fileURLWithPath: path)
//
//            // write the image data to the file URL
//            do {
//                try imageData.write(to: fileUrl, options: .atomic)
//            } catch {
//                // could not write image data
//                return
//            }
//
//            // instantiate a new document interaction controller
//            // you need to instantiate one document interaction controller per file
//            let documentController = UIDocumentInteractionController(url: fileUrl)
//            documentController.delegate = documentController.self
//            // the UTI is given by Instagram
//            documentController.uti = "com.instagram.photo"
//
//            // open the document interaction view to share to Instagram feed
//            documentController.presentOpenInMenu(from: self.view.frame, in: self.view, animated: true)
//        } else {
//            // Instagram app is not installed or can't be opened, pop up an alert
//        }
//    }
    
//    func postFacebook() {
//        //let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
//        self.shareView.setInitialText("Picture Text")
//        self.shareView.add(sketch.uiImage)
//        self.shareView.add(NSURL(string: "http://anyurl.com") as URL?)
//        //presentViewController(vc, animated: true, completion: nil)
//    }
}


struct SketchDetail_Previews: PreviewProvider {
    static var previews: some View {
        SketchDetail(sketch: sampleSketch)
    }
}
