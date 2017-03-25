//
//  PageTitleView.swift
//  DYZB
//
//  Created by 于洪志 on 2016/12/27.
//  Copyright © 2016年 于洪志. All rights reserved.
//

import UIKit
//定义协议
protocol PageTitleViewDelegate:class {
    func pageTitleView(titleView:PageTitleView,selectedIndex index:Int)
}


//定义常量
private let kScrollLineH:CGFloat = 2;
private let kNomalColor:(CGFloat,CGFloat,CGFloat)=(85,85,85)
private let kSelectedColor:(CGFloat,CGFloat,CGFloat) = (258,128,0)

class PageTitleView: UIView {
    
    private var currentIndex:Int=0
    
    
    private lazy var titleLabels:[UILabel] = [UILabel]()
    
    
    
    weak var delegate:PageTitleViewDelegate?
    
    private var titles:[String]
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemeted")
    }
    
    //MARK lanjiazai
    
    private lazy var scrollView:UIScrollView={
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    
    private func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupTitleLabel()
        setupBttomMenuAndScrollLine()
    }
    private func setupTitleLabel(){
        let labelW:CGFloat = frame.width/CGFloat(titles.count)
        
        
        let labelH:CGFloat = frame.height-kScrollLineH
        
        
        
        let labelY:CGFloat = 0
        for (index,title) in titles.enumerated(){
            let label = UILabel()
            print(title)
            print(index)
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r: kNomalColor.0, g: kNomalColor.1, b: kNomalColor.2)
            label.textAlignment = .center
            
            label.isUserInteractionEnabled = true;
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            let labelX:CGFloat = labelW*CGFloat(index)
            
            //设置label的frame
            
            
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //jia
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            
            
        }
    }
    
    private lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        return scrollLine
    }()
    private func setupBttomMenuAndScrollLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        
        
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        
        
        addSubview(bottomLine)
        //添加scrollLined
        //.1获取第一个label
        
        guard let fistLabel = titleLabels.first else {
            return
        }
        fistLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        let labelFrame = fistLabel.frame
        
        scrollLine.frame = CGRect(x: labelFrame.origin.x, y: frame.height-kScrollLineH, width: labelFrame.width, height: kScrollLineH)
       
        
        
    
        
        
    }
    
    
    
    //监听label的点击
    @objc private func titleLabelClick(tapGes:UITapGestureRecognizer){
       
        guard  let currentLabel=tapGes.view as?UILabel else {
            return
        }
        //获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //切换文字的颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        //保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        //滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag)*scrollLine.frame.width
        
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
            
        }
        
        
       
        
        
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
    
    //向外暴露的方法
    
    func setTitle(withProgress:CGFloat,souceIndex:Int,targetIndex:Int){
        print("progress:\(withProgress)")
        
        
        
        
        //处理滑块逻辑
        let sourceLabel = titleLabels[souceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x-sourceLabel.frame.origin.x
        
        let moveX = moveTotalX*withProgress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x+moveX
        //颜色的渐变化
        //3.1 取出变化的范围
        //3.2 sourclabel颜色变化的范围
        let colorDelta = (kSelectedColor.0-kNomalColor.0,kSelectedColor.1-kNomalColor.1,kSelectedColor.2-kNomalColor.2)
        sourceLabel.textColor = UIColor(r: kSelectedColor.0-colorDelta.0*withProgress, g: kSelectedColor.1-colorDelta.1*withProgress, b: kSelectedColor.2-colorDelta.2*withProgress)
        targetLabel.textColor = UIColor(r: kNomalColor.0+colorDelta.0*withProgress, g: kNomalColor.1+colorDelta.1*withProgress, b: kNomalColor.2+colorDelta.2*withProgress)
        //4.记录最新的index
        currentIndex = targetIndex
    }
    
}
