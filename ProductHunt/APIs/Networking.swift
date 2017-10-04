//
//  Networking.swift
//  ProductHunt
//
//  Created by Melody on 9/20/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation

//var session = URLSession.shared

let session = URLSession.shared

let baseURL = "https://api.producthunt.com/"
let post = "v1/me/feed"
let comments = "v1/comments"

enum Route {
    case post
    case comment(id: String)
    
    func path() -> String {
        switch self {
        case .post:
            return "v1/me/feed"
        case .comment:
            return "v1/comments"
        }
    }
    
    func header() -> [String: String] {
        let headers = ["Authorization": "Bearer 6b0322696a6344e8bfe6e753d3b21182d0ba30354ca013f9c67c1b603ced9675",
                       "Accept": "application/json",
                       "Content-Type": "application/json",
                       "Host": "api.producthunt.com"]
        return headers
    }
    func urlParams() -> [String: String] {
        switch self {
        case .post:
            let postParams = ["search[featured]": "true",
                                  "scope": "public",
                                  "per_page": "20"]
            return postParams
        case let .comment(id):
            let commentParams = ["search[post_id]": String(describing: id),
                            "scope": "public",
                            "per_page": "20"]
            return commentParams
        }
       
    }
    
}


class Networking {
    
    
    static var shared = Networking()
    
    let url = URL(string:"\(baseURL)\(post)")!
    
    func fetch(route: Route, completion: @escaping (Data) -> Void) {
        let fullURL = baseURL.appending(route.path())
        var url = URL(string: fullURL)!
        url = url.appendingQueryParameters(route.urlParams())
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = route.header()
        
        session.dataTask(with: request) { (data, response, error) in
            print("networking succeed")
            //let decodeModel = JSONDecoder()
            //let model = decodeModel.decode(type(of: model), from: data)
            if let data = data {
                completion(data)
            }
            else {
                print(error?.localizedDescription ?? "Error")
            }
        }.resume()
    }
}
    
    
//    func getFeaturedProducts(url: URL, completion: @escaping ([FeaturedProducts]) -> Void ) {
//
//        var request = URLRequest(url: url)
//        request.addValue("Bearer 6b0322696a6344e8bfe6e753d3b21182d0ba30354ca013f9c67c1b603ced9675", forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("api.producthunt.com", forHTTPHeaderField: "Host")
//
//        request.httpMethod = "GET"
//
//        session.dataTask(with: request) { (data, response, error) in
//            if let data = data {
//                print(data)
//
//                let productList = try? JSONDecoder().decode(ProductList.self, from: data)
//                guard let products = productList?.posts else { return }
//
//                completion(products)
//
//            }
//
//        }.resume()
//
//    }
    
//    static func getComments(id: Int, completion: @escaping ([Comments]) -> Void) {
//
//        let commentURL = URL(string: "\(baseURL)\(comments)")!
//
//        let date = Date()
//
//        let urlParam = ["search[post_id]": String(id),
//                        "scope": "public",
//                        "created_at": String(describing: date),
//                        "per_page": "20"]
//        let finalURL = commentURL.appendingQueryParameters(urlParam)
//
//
//        var request = URLRequest(url: finalURL)
//        request.addValue("Bearer 6b0322696a6344e8bfe6e753d3b21182d0ba30354ca013f9c67c1b603ced9675", forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("api.producthunt.com", forHTTPHeaderField: "Host")
//
//        request.httpMethod = "GET"
//
//        session.dataTask(with: request) { (data, response, error) in
//         guard error == nil else { return }
//
//            if let data = data {
//                print(data)
//
//                let commentList = try? JSONDecoder().decode(CommentList.self, from: data)
//                guard let comments = commentList?.comments else { return }
//
//                completion(comments)
//
//            }
//
//        }.resume()
//
//
//    }

    
 
    


protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    /**
     This computed property returns a query parameters string from the given NSDictionary. For
     example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
     string will be @"day=Tuesday&month=January".
     @return The computed parameters string.
     */
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}

extension URL {
    /**
     Creates a new URL by adding the given query parameters.
     @param parametersDictionary The query parameter dictionary to add.
     @return A new URL.
     */
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}


