//
//  Products.swift
//  ProductHunt
//
//  Created by Melody on 9/21/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation

struct Comments {

    var body: String

    init(body: String) {
        self.body = body
    }

}

struct CommentList: Decodable {
    let comments: [Comments]
}

extension Comments: Decodable {
    
    enum Comments: String, CodingKey {
        case body
    }
    
    init(from decoder: Decoder ) throws {
        let container = try decoder.container(keyedBy: Comments.self)
        let body = try container.decode(String.self, forKey: .body)
        
        self.init(body: body)
    }
    
    
}
