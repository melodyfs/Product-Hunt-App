//
//  Networking.swift
//  ProductHunt
//
//  Created by Melody on 9/20/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation

class Networking {
    
    static var shared = Networking()
    
    let baseURL = "https://api.producthunt.com/v1/me/feed"
    let session = URLSession.shared
    
    func getFeaturedProducts(url: URL, completion: @escaping ([FeaturedProducts]) -> Void ) {
        
        let url = URL(string:"\(baseURL)")!
        var request = URLRequest(url: url)
        request.addValue("Bearer 6b0322696a6344e8bfe6e753d3b21182d0ba30354ca013f9c67c1b603ced9675", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("api.producthunt.com", forHTTPHeaderField: "Host")
        
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                print(data)
                
                let productList = try? JSONDecoder().decode(ProductList.self, from: data)
                guard let products = productList?.posts else { return }
                completion(products)
            }
            
        }.resume()
    }
}


