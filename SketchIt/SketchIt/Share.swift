//
//  Share.swift
//  SketchIt
//
//  Created by Christian Guerrero on 4/25/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit


struct Share:  {
    <#fields#>
}
//    credit: https://www.8mincode.com/posts/how-to-share-an-image-on-instagram-with-ios-swift/
func shareToInstagramFeed(image: UIImage) {
    // build the custom URL scheme
    guard let instagramUrl = URL(string: "instagram://app") else {
        return
    }

    // check that Instagram can be opened
    if UIApplication.shared.canOpenURL(instagramUrl) {
        // build the image data from the UIImage
        guard let imageData = image.jpegData(compressionQuality: 100) else {
            return
        }

        // build the file URL
        let path = (NSTemporaryDirectory() as NSString).appendingPathComponent("instagram.ig")
        let fileUrl = URL(fileURLWithPath: path)

        // write the image data to the file URL
        do {
            try imageData.write(to: fileUrl, options: .atomic)
        } catch {
            // could not write image data
            return
        }

        // instantiate a new document interaction controller
        // you need to instantiate one document interaction controller per file
        let documentController = UIDocumentInteractionController(url: fileUrl)
        documentController.delegate = self
        // the UTI is given by Instagram
        documentController.uti = "com.instagram.photo"

        // open the document interaction view to share to Instagram feed
        documentController.presentOpenInMenu(from: self.view.frame, in: self.view, animated: true)
    } else {
        // Instagram app is not installed or can't be opened, pop up an alert
    }
}
