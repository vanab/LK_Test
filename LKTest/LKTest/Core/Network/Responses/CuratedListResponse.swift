//
//  CuratedListResponse.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 10.07.2024.
//

import Foundation

struct CuratedListResponse: Codable {
    let photos: [PhotoResponse]
    let nextPage: String?

    enum CodingKeys: String, CodingKey {
        case photos
        case nextPage = "next_page"
    }
}

struct PhotoResponse: Codable, Identifiable {
    let id: Int
    let height: Double
    let width: Double
    let src: PhotoSourceResponse
    let photographer: String

    enum CodingKeys: String, CodingKey {
        case id
        case src
        case photographer
        case height
        case width
    }
}

struct PhotoSourceResponse: Codable {
    let medium: String
    let original: String

    enum CodingKeys: String, CodingKey {
        case medium
        case original
    }
}
