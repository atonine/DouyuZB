//
//  RecomendViewModel.swift
//  DYZB
//
//  Created by 于洪志 on 2017/1/15.
//  Copyright © 2017年 于洪志. All rights reserved.
//

import UIKit

class RecomendViewModel {
    
    
    
    
    
  
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
    private var bigDataGroup:AnchorGroup = AnchorGroup()
    private var prettyGroup:AnchorGroup = AnchorGroup()
    
    func requestData(finishedCallBack:@escaping ()->())  {
        //1.定义残手
        let parameters :[String : Any] = ["limit":4,"offset":"0","time":Date.getCurrentTime()]
        //2.创建group
        let dGroup = DispatchGroup()
         //1.请求第一部分推荐数据
        dGroup.enter()
        NetWorkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":Date.getCurrentTime()]) { (result) in
            guard let resultDict = result as?[String:AnyObject] else{
                return
            }
            guard let dataArray =  resultDict["data"] as?[[String:AnyObject]]else{
                return
            }
           
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray{
                let anchor = AnchorModel.init(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            dGroup.leave()
            print("请求到底0组数据")
            
            
        }
        //2.请求第二部分的颜值数据
        dGroup.enter()
        NetWorkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            guard let resultDict = result as?[String:AnyObject] else{
                return
            }
            guard let dataArray =  resultDict["data"] as?[[String:AnyObject]]else{
                return
            }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray{
                let anchor = AnchorModel.init(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
             dGroup.leave()
            print("请求到底1组数据")
            
        }
        
       
        
        
        //3.请求后面的游戏数据
        dGroup.enter()
        NetWorkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4","offset":"0","time":Date.getCurrentTime()]) { (result) in
            guard let resultDict = result as?[String:AnyObject] else{
                return
            }
            guard let dataArray =  resultDict["data"] as?[[String:AnyObject]]else{
                return
            }
            for dict in dataArray{
                let group = AnchorGroup(dict)
                
                self.anchorGroups.append(group)
            }
            dGroup.leave()
            print("请求到底2-12组数据")
           
        }
        //所有的数据请求到了之后 进行一次排序
       
        dGroup.notify(queue: DispatchQueue.main) {
             self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
           finishedCallBack()
        }
    }
    
    func requestCycleData(_ finishCallback : @escaping () -> ()) {
        NetWorkTools.requestData(type: .get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishCallback()
        }
    }
    //MARK-定时器操作方法
  
}

