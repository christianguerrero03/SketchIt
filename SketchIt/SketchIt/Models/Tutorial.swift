//
//  Tutorial.swift
//  SketchingAlpha
//
//  Created by Christian Guerrero on 1/27/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import Foundation
import SwiftUI

//struct Tutorial: Hashable, Codable, Identifiable {
struct Tutorial: Codable, Identifiable {
    var kind: String
    var id: String
    var _id: Id
    var snippet: Snippet
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case kind
        case id = "etag"
        case _id = "id"
        case snippet
    }
}

struct Id: Codable {
    var kind: String
    var videoId: String?
}

struct Snippet: Codable {
    var publishedAt: String
    var channelId: String?
    var title: String
    var description: String
    var thumbnails: Thumbnails
    var channelTitle: String
    var liveBroadcastContent: String
}

struct Thumbnails: Codable {
    var `default`: Thumbnail
    var medium: Thumbnail
    var high: Thumbnail
}

struct Thumbnail: Codable {
    var url: String
    var height: NSInteger?
    var width: NSInteger?
}


