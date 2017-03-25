//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by 于洪志 on 2017/3/1.
//  Copyright © 2017年 于洪志. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionBaseCell: UICollectionViewCell {
    @IBOutlet weak var onlineButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    var anchor:AnchorModel?{
        didSet{
            guard let anchor = anchor else {
                return
            }
            var onlineStr = ""
            if anchor.online>10000 {
                onlineStr  = "\(anchor.online/10000)万在线"
            }
            else{
                onlineStr = "\(anchor.online)"
            }
            onlineButton.setTitle(onlineStr, for: UIControlState())
            let imgURL = URL.init(string: anchor.vertical_src)
            iconImageView.kf.setImage(with: imgURL)
            nickNameLabel.text = anchor.nickname
        }
    }
    
    
}
