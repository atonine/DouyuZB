//
//  CycleModel.swift
//  DYZB
//
//  Created by 于洪志 on 2017/3/2.
//  Copyright © 2017年 于洪志. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    var title:String = ""
    var pic_url = ""
    
    
    var room:[String:Any]?{
        didSet{
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
            
        }
        
    }
    init(dict:[String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    var anchor:AnchorModel?
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
