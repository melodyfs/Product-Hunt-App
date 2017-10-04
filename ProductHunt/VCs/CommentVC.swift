//
//  CommentVC.swift
//  ProductHunt
//
//  Created by Melody on 9/23/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

class CommentVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postID = 0
    
    var comment: [Comments] = [] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Networking.shared.fetch(route: .comment(id: String(describing:postID))) { (response) in
            print(response)
            let commentList = try? JSONDecoder().decode(CommentList.self, from: response)
            guard let comments = commentList?.comments else { return }
            
            self.comment = comments
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   

}

extension CommentVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
        let comments = comment[indexPath.row]
        
        cell.commentsLabel.text = comments.body
        
        return cell
    }

    
}

extension CommentVC: UITableViewDelegate {
    
}

    




