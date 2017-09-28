//
//  RestaurantTableViewCell.swift
//  PracticalExam
//
//  Created by mobile.dev on 9/25/17.
//  Copyright © 2017 praticalexam.com. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet var listItemView: UIView!
    @IBOutlet var photo: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var distance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        listItemView.layer.borderWidth = 0.5
        listItemView.layer.borderColor = UIColor.gray.cgColor
        listItemView.layer.cornerRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
