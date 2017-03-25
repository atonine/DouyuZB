//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 于洪志 on 2017/1/3.
//  Copyright © 2017年 于洪志. All rights reserved.
//

import UIKit



private let kItemMargin:CGFloat = 10

private let kItemW = (kScreen-3*kItemMargin)/2


private let kItemNormalH = kItemW * 3/4
private let kItemPrettyH = kItemW * 4/3
private let kNormalCellID = "recCellId"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderView"
private let kCycleViewH = kScreen * 3 / 8
private let kHeaderViewH:CGFloat = 50
class RecommendViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    fileprivate lazy var recommendVM : RecomendViewModel = RecomendViewModel()
    
    
    private lazy var cycleView:RecommendCycleView={
       var cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect.init(x: 0, y: -kCycleViewH, width: kScreen, height: kCycleViewH)
        return cycleView
    }()
    
    private lazy var collectionView:UICollectionView={[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemNormalH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        //2.创建UICollectionView
        layout.headerReferenceSize = CGSize(width: kScreen, height: kHeaderViewH)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        
        collectionView.delegate = self
//        collectionView.autoresizingMask=[.flexibleHeight,.flexibleWidth]
        collectionView.register( UINib(nibName: "CollectionNomalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID);
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register( UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        print(Date.getCurrentTime())
      // collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
//       NetWorkTools.requestData(URLString: "https://httpbin.org/get") { (result) in
//        print(result)
//        }
//        NetWorkTools.requestData(URLString: "https://httpbin.org/get", parameters: ["name" : "why"]) { (result) in
//            print(result)
//        }
       // collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        // Do any additional setup after loading the view.
       setupUI()
       loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK-设置UI界面内容
    private func setupUI(){
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0)
        
    }
    
    //MARK-请求数据
    private func loadData(){
        
        recommendVM.requestData {
            self.collectionView.reloadData()
        }
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
    //MARK-请求轮播数据
    
    //MARK-遵守数据源方法
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group  = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        //1.获取Cell
      //  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
      
        if indexPath.section==1 {
          
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)as!CollectionPrettyCell
            cell.anchor = anchor
            return cell
        }else{
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNomalCell
            prettyCell.anchor = anchor
            return prettyCell
          
        }
//        cell.backgroundColor = UIColor.red
       
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的HeaderView
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as!CollectionHeaderView
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        
        
        return headerView
    }
    //MARK-遵守代理方法
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section==1 {
            return CGSize(width: kItemW, height: kItemPrettyH)
        }
        return CGSize(width: kItemW, height: kItemNormalH)
    }
    
    
}
extension RecommendViewController{
   
}
