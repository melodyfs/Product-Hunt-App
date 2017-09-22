//
//  ViewController.swift
//  ProductHunt
//
//  Created by Melody on 9/20/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    private let networking = Networking()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // networking.delegate = self
        Networking.shared.getFeaturedProducts(url: Networking.shared.url) { (response) in
            print(response)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

//extension HomeVC: NetworkingDelegate {
//
//    func didRecieveDataUpdate(data: String) {
//        print(data)
//    }
//}



    
    





