//
//  CameraView.swift
//  SketchingAlpha
//
//  Created by Christian Guerrero on 2/13/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

struct CameraView {
    
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var uiImage: UIImage?
    @Binding var share: Bool
    var source: String
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image, uiImage: $uiImage, share: $share)
    }
}

extension CameraView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        if (source == "camera") {
            picker.sourceType = .camera
        }
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CameraView>) {
        
    }
}
