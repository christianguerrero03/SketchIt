//
//  YoutubeData.swift
//  SketchingAlpha
//
//  Created by Christian Guerrero on 1/26/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

// *** INSERT RED CORVUS API KEY ***
//let API_KEY = ""
// remove old key:
let API_KEY = "AIzaSyDH4L8pPZ0Dm9TOa4sbpknN5Ca_U407DS4"
var tutorialData: YTResponse?
var favoriteData: [String:Bool] = [:]

let session = URLSession.shared
let url = URL(string:
"https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UCWumue2Heygq9-ZiLOahfrQ&maxResults=50&type=video&key="+API_KEY)!

let task = session.dataTask(with: url) { data, response, error in

    if error != nil || data == nil {
        print("Client error!")
        return
    }

    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
        print("Server error!")
        return
    }

    guard let mime = response.mimeType, mime == "application/json" else {
        print("Wrong MIME type!")
        return
    }

    do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(YTResponse.self, from: data!)
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

func getYoutubeResults () {
    task.resume()
}

