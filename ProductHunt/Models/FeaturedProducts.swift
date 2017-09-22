//
//  FeaturedProducts.swift
//  ProductHunt
//
//  Created by Melody on 9/20/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation

struct FeaturedProducts {
    
    var name: String
    var tagline: String
    var votes: Int
    var thumbnail: URL
    
    init(name: String, tagline: String, votes: Int, thumbnail: URL) {
        self.name = name
        self.tagline = tagline
        self.votes = votes
        self.thumbnail = thumbnail
    }
}

struct ProductList: Decodable {
    let posts: [FeaturedProducts]
}

extension FeaturedProducts: Decodable {
    
    enum Posts: String, CodingKey {
        case name
        case tagline
        case thumbnail
        case votes = "votes_count"
    }
    
    enum Thumbnail: String, CodingKey {
        case imageURL = "image_url"
    }
    
    init(from decoder: Decoder ) throws {
        let container = try decoder.container(keyedBy: Posts.self)
        let thumbnailContainer = try container.nestedContainer(keyedBy: Thumbnail.self, forKey: .thumbnail)
        
        let name: String = try container.decode(String.self, forKey: .name)
        let tagline: String = try container.decode(String.self, forKey: .tagline)
        let votes: Int = try container.decode(Int.self, forKey: .votes)
        let thumbnail : URL = try thumbnailContainer.decode(URL.self, forKey: .imageURL)
        
        self.init(name: name, tagline: tagline, votes: votes, thumbnail: thumbnail)
    }
    
}

