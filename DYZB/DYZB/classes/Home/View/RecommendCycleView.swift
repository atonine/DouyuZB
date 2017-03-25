//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by 于洪志 on 2017/3/1.
//  Copyright © 2017年 于洪志. All rights reserved.
//

import UIKit
private let kCycleCellID="kCycleCellID"
class RecommendCycleView: UIView {

    var cycleModels:[CycleModel]?{
        didSet{
            cycleCollectionView.reloadData()
            pageControl.numberOfPages = cycleModels?.count ?? 0
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0)*10, section: 0)
            
            cycleCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var cycleCollectionView: UICollectionView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = cycleCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = cycleCollectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        cycleCollectionView.isPagingEnabled = true
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing()
      cycleCollectionView.register(UINib.init(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }

}
extension RecommendCycleView{
    class func recommendCycleView()->RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}
extension RecommendCycleView:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width*0.5
        pageControl.currentPage = Int(offsetX/scrollView.bounds.width)%(cycleModels?.count ?? 1)
    }
}

extension RecommendCycleView:UICollectionViewDataSource{
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath)as! CollectionCycleCell
        cell.cycleModel = self.cycleModels![indexPath.item%cycleModels!.count]
//        if indexPath.item%2==0  {
//            cell.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
//        }else{
//            cell.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
//        }
        return cell
    }

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0)*10000
    }

    
}
