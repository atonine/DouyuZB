//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by 于洪志 on 2017/3/1.
//  Copyright © 2017年 于洪志. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {


   
    @IBOutlet weak var cityButton: UIButton!
    
    override var anchor: AnchorModel?{
        didSet{
            super.anchor = anchor
            cityButton.setTitle(anchor?.anchor_city, for: UIControlState())
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
