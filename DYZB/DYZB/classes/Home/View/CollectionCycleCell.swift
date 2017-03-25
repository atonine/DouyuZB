//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by 于洪志 on 2017/3/1.
//  Copyright © 2017年 于洪志. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var cycleModel:CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            let iconURL = URL.init(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: #imageLiteral(resourceName: "Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
            
        }
    }
    

}
