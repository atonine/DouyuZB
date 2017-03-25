//
//  HomeViewController.swift
//  DYZB
//
//  Created by 于洪志 on 2016/12/26.
//  Copyright © 2016年 于洪志. All rights reserved.
//

import UIKit

private let kTitleViewH:CGFloat = 40

class HomeViewController: UIViewController,PageTitleViewDelegate,PageContentViewDelegate {
    
    private lazy var pageTitleView:PageTitleView  = {
        [weak self]in
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavigionBarH, width: kScreen, height: kTitleViewH)
        let titles  = ["推荐","游戏","娱乐","趣玩"];
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        //titleView.backgroundColor = UIColor.purple;
        titleView.delegate = self
        return titleView
    }()
    
    
    private lazy var pageContentView:PageContentView = {
        [weak self] in
        //确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigionBarH - kTitleViewH-kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH+kNavigionBarH+kTitleViewH, width: kScreenH, height: contentH)
        
        
        //确定所有子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        
        
        setupNavigationBar()
        
        self.view.addSubview(pageTitleView)
        self.view.addSubview(pageContentView)
    }
    private func setupNavigationBar(){
        let btn = UIButton()
        btn.setImage(UIImage(named:"logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        
        let size = CGSize(width: 40, height: 40);
        
//        let historyBtn = UIButton();
//        
//        historyBtn.setImage(#imageLiteral(resourceName: "image_my_history"), for: .normal)
//        historyBtn.setImage(#imageLiteral(resourceName: "Image_my_history_click"), for: .highlighted)
//        historyBtn.frame = CGRect(origin:CGPoint(x:0,y:0), size: size)
        let history = UIBarButtonItem(image: #imageLiteral(resourceName: "image_my_history"), hightlightImage: #imageLiteral(resourceName: "Image_my_history_click"), size: size)
        
    //    let searchBtn = UIButton();
        
//        searchBtn.setImage(#imageLiteral(resourceName: "btn_search"), for: .normal)
//        searchBtn.setImage(#imageLiteral(resourceName: "btn_search_clicked"), for: .highlighted)
//        searchBtn.frame = CGRect(origin:CGPoint(x:0,y:0), size: size)
        let searchItem = UIBarButtonItem(image: #imageLiteral(resourceName: "btn_search"), hightlightImage: #imageLiteral(resourceName: "btn_search_clicked"), size: size)
//        let imageScanBtn = UIButton();
//        
//        imageScanBtn.setImage(#imageLiteral(resourceName: "Image_scan"), for: .normal)
//        imageScanBtn.setImage(#imageLiteral(resourceName: "Image_scan_click"), for: .highlighted)
//        imageScanBtn.frame = CGRect(origin:CGPoint(x:0,y:0), size: size)
        
        let imageScanItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Image_scan"), hightlightImage: #imageLiteral(resourceName: "Image_scan_click"), size: size)

     
        
        
        navigationItem.rightBarButtonItems = [history,searchItem,imageScanItem];
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //mark 遵守pageTitleView协议
    
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndx(currentIndex: index)
    }
    //mark 遵守pageContentView协议
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitle(withProgress: progress, souceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
