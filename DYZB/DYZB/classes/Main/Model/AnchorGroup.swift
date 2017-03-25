//
//  AnchorGroup.swift
//  DYZB
//
//  Created by 于洪志 on 2017/1/15.
//  Copyright © 2017年 于洪志. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    //该组中对应的房间信息
    var room_list:[[String:AnyObject]]?{
        didSet{
            guard let room_list = room_list else {return}
            for dict in room_list{
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    //组显示的标题
    var tag_name:String = ""
    //组显示图标
    var icon_name:String = "home_header_normal"
    //
    
    
    override init(){
        
    }
    lazy var anchors:[AnchorModel]=[AnchorModel]()
    init(_ dict:[String:Any]){
        super.init()
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
