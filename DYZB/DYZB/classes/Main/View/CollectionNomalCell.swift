//
//  CollectionNomalCell.swift
//  DYZB
//
//  Created by 于洪志 on 2017/3/1.
//  Copyright © 2017年 于洪志. All rights reserved.
//

import UIKit

class CollectionNomalCell: CollectionBaseCell {

    
    
    @IBOutlet weak var roomNameLabel: UILabel!
    override var anchor: AnchorModel?{
        didSet{
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
