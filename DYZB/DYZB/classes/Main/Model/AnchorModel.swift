//
//  AnchorModel.swift
//  DYZB
//
//  Created by 于洪志 on 2017/1/16.
//  Copyright © 2017年 于洪志. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    var room_id:Int = 0
    
    //房间 图片对应的url
    var vertical_src = ""
    //判断手机 电脑直播
    var isVertical = 0
    
    //房间名字
    var room_name = ""
    
    //主播昵称
    var nickname = ""
    
    
    //在线人数
    var online:Int = 0
    //所在城市
    var anchor_city = ""
    //在线人数
  
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
}
