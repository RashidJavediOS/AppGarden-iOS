//
//  FlickerResponseModel.swift
//  AppGarden
//
//  Created by  Rashid Javed on 24/09/2024.
//

import Foundation

// Flickr API Model
struct FlickrPhoto: Codable, Identifiable {
    let id = UUID() // Local UUID to satisfy Identifiable protocol
    let title: String
    let media: Media
    let description: String
    let author: String
    let published: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case media
        case description = "description"
        case author = "author"
        case published = "published"
    }
}

struct Media: Codable {
    let m: String
}

