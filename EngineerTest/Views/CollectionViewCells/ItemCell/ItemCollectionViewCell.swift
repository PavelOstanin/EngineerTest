//
//  ItemCollectionViewCell.swift
//  EngineerTest
//
//  Created by Pavel Ostanin on 6/4/19.
//  Copyright © 2019 pavel.ostanin. All rights reserved.
//

import UIKit
import Kingfisher

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    func setup(with item: Item?) {
        if let item = item {
            if let image = item.image, let url = URL.init(string: image) {
                itemImageView.kf.setImage(with: url)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
    }
    
}
