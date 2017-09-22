//
//  HomeTableViewCell.swift
//  ProductHunt
//
//  Created by Melody on 9/21/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var thumbnailImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
