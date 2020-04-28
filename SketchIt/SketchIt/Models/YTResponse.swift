//
//  YTResponse.swift
//  SketchingAlpha
//
//  Created by Christian Guerrero on 1/27/20.
//  Copyright © 2020 Christian Guerrero. All rights reserved.
//

import Foundation
import SwiftUI

struct YTResponse: Codable {
    //var id: String
    var kind: String
    var etag: String
    var nextPageToken: String?
    var regionCode: String
//    var pageInfo: [(totalResults: NSInteger, resultsPerPage: NSInteger)]
    var pageInfo: PageInfo
    var items: [Tutorial]

//    private enum CodingKeys: String, CodingKey {
//        case kind
//        case etag
//        case nextPageToken
//        case regionCode
//        case pageInfo
//        case items
//    }
    
//    init(from decoder:Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        kind = try values.decode(String.self, forKey: .kind)
//        etag = try values.decode(String.self, forKey: .etag)
//        nextPageToken = try values.decode(String.self, forKey: .nextPageToken)
//        regionCode = try values.decode(String.self, forKey: .regionCode)
//        pageInfo = try values.decode(String.self, forKey: .pageInfo)
//        items = try values.decode([Tutorial].self, forKey: .items)
//    }
    
//    init?(json: [String: Any]) {
//        //id = json["etag"] as! String
//        kind = json["kind"] as! String
//        etag = json["etag"] as! String
//        nextPageToken = json["nextPageToken"] as! String
//        regionCode = json["regionCode"] as! String
////        pageInfo = json["kind"] as! (totalResults: NSInteger, resultsPerPage: NSInteger)
//        pageInfo = json["kind"] as! String
//        items = json["items"] as! [[String: Any]]
//    }
}
struct PageInfo: Codable {
    var totalResults: NSInteger
    var resultsPerPage: NSInteger
}
