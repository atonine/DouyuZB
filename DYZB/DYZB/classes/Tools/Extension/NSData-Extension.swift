//
//  NSData-Extension.swift
//  DYZB
//
//  Created by 于洪志 on 2017/1/15.
//  Copyright © 2017年 于洪志. All rights reserved.
//

import Foundation


extension Date {
    static func getCurrentTime()->String{
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
    
}
