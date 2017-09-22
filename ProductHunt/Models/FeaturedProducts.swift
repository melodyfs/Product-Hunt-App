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
    var id: Int
    var votes: Int
    var thumbnail: URL
    var discussion: URL
    
    init(name: String, tagline: String, id: Int, votes: Int, thumbnail: URL, discussion: URL) {
        self.name = name
        self.tagline = tagline
        self.id = id
        self.votes = votes
        self.thumbnail = thumbnail
        self.discussion = discussion
    }
}

struct ProductList: Decodable {
    let posts: [FeaturedProducts]
}

extension FeaturedProducts: Decodable {
    
    
    
    enum Posts: String, CodingKey {
        case name
        case tagline
        case id
        case thumbnail
        case votes = "votes_count"
        case discussion = "discussion_url"
    }
    
    enum Thumbnail: String, CodingKey {
        case imageURL = "image_url"
    }
    
    init(from decoder: Decoder ) throws {
        let container = try decoder.container(keyedBy: Posts.self)
        let thumbnailContainer = try container.nestedContainer(keyedBy: Thumbnail.self, forKey: .thumbnail)
        
        let name: String = try container.decode(String.self, forKey: .name)
        let tagline: String = try container.decode(String.self, forKey: .tagline)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let votes: Int = try container.decode(Int.self, forKey: .votes)
        let thumbnail: URL = try thumbnailContainer.decode(URL.self, forKey: .imageURL)
        let discussion: URL = try container.decode(URL.self, forKey: .discussion)
        
        self.init(name: name, tagline: tagline, id: id, votes: votes, thumbnail: thumbnail, discussion: discussion)
        
        
    }
    
}

