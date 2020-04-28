//
//  Coordinator.swift
//  SketchingAlpha
//
//  Created by Christian Guerrero on 2/13/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import Foundation
import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @Binding var isCoordinatorShown: Bool
  @Binding var imageInCoordinator: Image?
  @Binding var uiImageInCoordinator: UIImage?
  @Binding var isShareShown: Bool
    init(isShown: Binding<Bool>, image: Binding<Image?>, uiImage: Binding<UIImage?>, share: Binding<Bool>) {
    _isCoordinatorShown = isShown
    _imageInCoordinator = image
    _uiImageInCoordinator = uiImage
    _isShareShown = share
  }
  func imagePickerController(_ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
     uiImageInCoordinator = self.resizeImage(image: unwrapImage)
     imageInCoordinator = Image(uiImage: uiImageInCoordinator!)
     isCoordinatorShown = false
     isShareShown = true
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     isCoordinatorShown = false
  }

  func resizeImage(image: UIImage) -> UIImage {
      print("resizeImage()")
      let width = image.size.width
      let height = image.size.height
      UIGraphicsBeginImageContext(CGSize(width: width, height: height))
      image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return newImage!
  }
}
