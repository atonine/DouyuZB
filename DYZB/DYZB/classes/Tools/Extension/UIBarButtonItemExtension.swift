//
//  UIBarButtonItemExtension.swift
//  DYZB
//
//  Created by 于洪志 on 2016/12/26.
//  Copyright © 2016年 于洪志. All rights reserved.
//

import UIKit


extension UIBarButtonItem{
//    class func createItem(image:UIImage?,hightlightImage:UIImage?,size:CGSize)->UIBarButtonItem{
//        let btn = UIButton()
//        
//        btn.setImage(image, for: .normal)
//        btn.setImage(hightlightImage, for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint(x:0,y:0), size: size);
//        return UIBarButtonItem(customView: btn)
//    }
    
    
    convenience init(image:UIImage?,hightlightImage:UIImage?,size:CGSize) {
        let btn = UIButton()
        
        btn.setImage(image, for: .normal)
        btn.setImage(hightlightImage, for: .highlighted)
        btn.frame = CGRect(origin: CGPoint(x:0,y:0), size: size);
        self.init(customView:btn)
    }
}
