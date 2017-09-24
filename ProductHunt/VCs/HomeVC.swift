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
    
    
    var products: [FeaturedProducts] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.estimatedRowHeight = 60
        
       // networking.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
        Networking.getFeaturedProducts(url: Networking.shared.url) { (response) in
            print(response)
            self.products = response
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

extension HomeVC: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! HomeTableViewCell
        let product = products[indexPath.row]
        
        cell.nameLabel.text = product.name
        cell.taglineLabel.text = product.tagline
        cell.votesLabel.text = String(product.votes)
        
        
        
        
        return cell
    }
    
    
}

extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        let postID = product.id
        
        //getting corresponding comments of the product
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let commentVC = storyboard.instantiateViewController(withIdentifier: "commentVC") as! CommentVC
        commentVC.postID = postID
        navigationController?.pushViewController(commentVC, animated: true)
        
    }
    
}


//extension HomeVC: NetworkingDelegate {
//
//    func didRecieveDataUpdate(data: String) {
//        print(data)
//    }
//}



    
    





