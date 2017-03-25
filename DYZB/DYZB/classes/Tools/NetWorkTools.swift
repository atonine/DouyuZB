//
//  NetWorkTools.swift
//  DYZB
//
//  Created by 于洪志 on 2017/1/14.
//  Copyright © 2017年 于洪志. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}


class NetWorkTools: NSObject {
    class func requestData(type:MethodType,URLString:String,parameters:[String:Any]?=nil,finishedCallBack:@escaping (_ result:Any)->()){
        
        
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error ?? "")
                return
            }
            finishedCallBack(result)
        }
       
        
    }
}
