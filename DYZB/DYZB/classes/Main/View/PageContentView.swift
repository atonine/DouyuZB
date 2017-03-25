//
//  PageContentView.swift
//  DYZB
//
//  Created by 于洪志 on 2016/12/27.
//  Copyright © 2016年 于洪志. All rights reserved.
//

import UIKit



private let cellID="collectionCell"

protocol PageContentViewDelegate:class {
    func pageContentView(contentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}
class PageContentView: UIView,UICollectionViewDataSource,UICollectionViewDelegate  {

    
    private var childVcs:[UIViewController]
    private weak var parentViewController:UIViewController?
    
    private var startOffsetX:CGFloat = 0
    private var isForbidScrollDelegate = false
    //代理
    weak var delegate:PageContentViewDelegate?
    private lazy var collectionView:UICollectionView = {
       //创建layout
        [weak self] in
        let layout = UICollectionViewFlowLayout()
        
        
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal
        
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout:layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        
        //代理方法和数据源
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //mark - 配置UI界面
    private func setupUI(){
        //将所有自控制器添加到父控制器
        
        
        for childVC in childVcs{
            
            
            parentViewController?.addChildViewController(childVC)
            
            addSubview(collectionView)
            collectionView.frame = bounds
            
        }
    }
    
    
    
    //UICollection 数据源方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
    
    //UICollection代理方法
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate {
            return
        }
        var progress:CGFloat = 0;
        var SouceIndex = 0;
        var targetIndex = 0;
        
        //判断是左滑还是右滑
        
        let currentOffsetX = scrollView.contentOffset.x
        
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX>startOffsetX{//左滑
           let ratio = currentOffsetX/scrollViewW
          progress = ratio - floor(ratio)
            SouceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = SouceIndex+1
            if targetIndex>=childVcs.count {
                targetIndex = childVcs.count-1
            }
            if currentOffsetX-startOffsetX==scrollViewW {
                progress=1
                targetIndex = SouceIndex
            }
        }else{
            let ratio = currentOffsetX/scrollViewW
            progress = 1-(ratio - floor(ratio))
             targetIndex = Int(currentOffsetX/scrollViewW)
            SouceIndex = targetIndex+1
            if SouceIndex>=childVcs.count {
                SouceIndex = childVcs.count-1
            }
            
        }
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: SouceIndex, targetIndex: targetIndex)
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate=false
        startOffsetX = scrollView.contentOffset.x
        
    }
    //向外暴露的方法
    
    
    func setCurrentIndx(currentIndex:Int){
        isForbidScrollDelegate = true
        let OffsetX = CGFloat(currentIndex)*collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:OffsetX,y:0), animated: false)
    }
    
    
}



