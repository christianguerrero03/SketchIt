//
//  Sketch.swift
//  SketchItBeta
//
//  Created by Christian Guerrero on 2/23/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import Foundation
import SwiftUI

struct Sketch2: Identifiable {
    var id: Int
    //var image: Image
    var uiImage: UIImage
    var title: String
    var date: Date
    var tutorial: Tutorial
    
//    enum Key:String {
//        case id = "id"
//        case uiImage = "uiImage"
//        case title = "title"
//        case date = "date"
//        case tutorial = "tutorial"
//    }
//
//    init(id: Int, uiImage: UIImage, title: String, date: Date, tutorial: Tutorial) {
//        self.id = id
//        self.uiImage = uiImage
//        self.title = title
//        self.date = date
//        self.tutorial = tutorial
//    }
//
//    public override init() {
//        super.init()
//    }
//
//    public func encode(with coder: NSCoder) {
//        coder.encode(id, forKey: Key.id.rawValue)
//        coder.encode(uiImage, forKey: Key.uiImage.rawValue)
//        coder.encode(title, forKey: Key.title.rawValue)
//        coder.encode(date, forKey: Key.date.rawValue)
//        coder.encode(tutorial, forKey: Key.tutorial.rawValue)
//    }
//
//    public required init?(coder: NSCoder) {
//        let mId = coder.decodeInt32(forKey: Key.id.rawValue)
//        let mUIImage = coder.decodeInt32(forKey: Key.uiImage.rawValue)
//        let mTitle = coder.decodeInt32(forKey: Key.title.rawValue)
//        let mDate = coder.decodeInt32(forKey: Key.date.rawValue)
//        let mTutorial = coder.decodeInt32(forKey: Key.tutorial.rawValue)
//    }
    
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
