//
//  UserTableViewCell.swift
//  EngineerTest
//
//  Created by Pavel Ostanin on 6/4/19.
//  Copyright © 2019 pavel.ostanin. All rights reserved.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    @IBOutlet weak var constraintCollectionViewHeight: NSLayoutConstraint!
    
    var items: [Item?] = []
    let inset: CGFloat = 15
    

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.layer.masksToBounds = true
        itemsCollectionView.dataSource = self
        itemsCollectionView.delegate = self
    }
    
    func setup(with user: User?) {
        if let user = user {
            nameLabel.text = user.name
            if let image = user.image, let url = URL.init(string: image) {
                avatarImageView.kf.setImage(with: url)
            }
            items = user.items
            let height = (itemsCollectionView.frame.size.width - inset) / 2
            if items.count == 0 {
                constraintCollectionViewHeight.constant = 0
            }
            else {
                let rowCount = CGFloat(items.count / 2 + items.count % 2)
                constraintCollectionViewHeight.constant = rowCount * height + (rowCount - 1) * inset
            }
            layoutIfNeeded()
            itemsCollectionView.reloadData()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = UIImage(named: "avatar")
    }

}

extension UserTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        cell.setup(with: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isOdd = items.count % 2 != 0
        let height = (collectionView.frame.size.width - inset) / 2
        let width = (isOdd && indexPath.item == 0) ? collectionView.frame.size.width : height
        return CGSize(width: width, height: height)
    }
    
}
