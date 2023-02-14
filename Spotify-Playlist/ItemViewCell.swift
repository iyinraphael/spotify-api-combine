//
//  ItemViewCell.swift
//  Spotify-Playlist
//
//  Created by Iyin Raphael on 2/13/23.
//

import UIKit

class ItemViewCell: UICollectionViewCell {

    @IBOutlet weak var ItemImage: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var detailLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }


    func updateCell(with item: Item) {

    }

}
