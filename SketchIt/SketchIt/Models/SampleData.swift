//
//  SamlpeTutorial.swift
//  SketchingAlpha
//
//  Created by Christian Guerrero on 1/29/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import Foundation
import SwiftUI

var sample: Tutorial = Tutorial(kind: "kind", id: "id123", _id: Id(kind: "kind", videoId: "d963-NfQRio"), snippet: Snippet(publishedAt: "publishedAt", channelId: "channelId", title: "Easy Sketching: Camellia Flower", description: "How to draw: Bloom on branch. Step-by-step instructions for drawing the first sign of spring! #sketching #drawing #flower #camellia.", thumbnails: Thumbnails(default: Thumbnail(url: "https://i.ytimg.com/vi/d963-NfQRio/default.jpg", height: 90, width: 120), medium: Thumbnail(url: "https://i.ytimg.com/vi/d963-NfQRio/mqdefault.jpg", height: 180, width: 320), high: Thumbnail(url: "https://i.ytimg.com/vi/d963-NfQRio/hqdefault.jpg", height: 360, width: 480)), channelTitle: "Red Corvus Design", liveBroadcastContent: "false"))

//var sampleSketch: Sketch = Sketch(id: 0, uiImage: UIImage(named: "sketch")!, title: "Sketch 1", date: Date(), tutorial: sample)

var sampleSketch: Sketch = Sketch()

func initSample() {
    var sample = Sketch()
    sample.title = "Sample"
    sample.uiImage = UIImage(named: "noimage")?.jpegData(compressionQuality: 1.0)
    sample.date = Date()
}

var sketchData: [Sketch] = []

func getSampleSketch() {
    sketchData.append(sampleSketch)
}

func getSampleTutorial () {
    var data: Data
    do {
        guard let file = Bundle.main.url(forResource: "data.json", withExtension: nil)
            else {
                fatalError("Couldn't find \"data.json\" in main bundle.")
        }
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \"data.json\" from main bundle:")
        }
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(YTResponse.self, from: data)
        tutorialData = response
        for n in 0...(tutorialData!.items.count - 1) {
            if (nil == favoriteData[tutorialData!.items[n]._id.videoId!]){
                favoriteData[tutorialData!.items[n]._id.videoId!] = false
            }
        }
    } catch {
        print("JSON error: \(error.localizedDescription)")
        print(error)
    }
}
