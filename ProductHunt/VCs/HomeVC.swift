//
//  ViewController.swift
//  ProductHunt
//
//  Created by Melody on 9/20/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit



class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var products: [FeaturedProducts] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.estimatedRowHeight = 60
        
       // networking.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
        Networking.shared.getFeaturedProducts(url: Networking.shared.url) { (response) in
            print(response)
            self.products = response
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        Networking.shared.getComments(id: Double(products.index(before: 3))) { (response) in
            print(response)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

extension HomeVC: UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 5
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell") as! HomeTableViewCell
        let product = products[indexPath.row]
        
        cell.nameLabel.text = product.name
        cell.taglineLabel.text = product.tagline
        cell.votesLabel.text = String(product.votes)
        
        
        
        
        return cell
    }
    
    
}

extension HomeVC: UITableViewDelegate {
    
}


//extension HomeVC: NetworkingDelegate {
//
//    func didRecieveDataUpdate(data: String) {
//        print(data)
//    }
//}



    
    





