//
//  SwiftLoopView.swift
//  SwiftLoopView
//
//  Created by Lanvige Jiang on 4/22/15.
//  Copyright (c) 2015 Lanvige Jiang. All rights reserved.
//

import UIKit

public class SwiftLoopModelBase {
    public init() { }
}

public class SwiftBaseCollectionCell: UICollectionViewCell {
    public var model: SwiftLoopModelBase

    
    public init(frame: CGRect, model: SwiftLoopModelBase) {
        self.model = model
        
        super.init(frame: frame)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


public class SwiftLoopView: UIView {

    // MARK: Properties
    
    private var placeholder: UIImage?
    private let kCellIdentifier = "ReuseCellIdentifier"
    
    public var models: [SwiftLoopModelBase]?
    
    public let greetingPrinter: () -> () = {}
    
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    
    public init(frame: CGRect, models: [SwiftLoopModelBase]) {
        
        
        super.init(frame: frame)
        
        self.models = models
//        self.collectionView.reloadData()
        self.addSubview(self.collectionView)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAZY
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: self.collectionLayout)
        collectionView.backgroundColor = UIColor.lightTextColor()
        collectionView.pagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: self.kCellIdentifier)
    
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.scrollEnabled = true
    
        return collectionView
    }()
    
    private lazy var collectionLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        
        return layout
    }()
    
//    private lazy var defaultCollectionCell: SwiftBaseCollectionCell = {
//        let cell = SwiftBaseCollectionCell()
//        
//        return cell
//    }()
    
    // MARK: - UIView
    
    public override func layoutSubviews() {
        //
    }
}


extension SwiftLoopView: UICollectionViewDataSource {
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let modelsValue = self.models {
            return modelsValue.count * 50
        }
        
        return 0
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(self.kCellIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        
        var count = 0
        
        if let modelValue = self.models {
            count = modelValue.count
        }
        
        var a = indexPath.row % count
        
        
        switch (a) {
        case 0:
            cell.backgroundColor = UIColor.redColor()
        case 1:
            cell.backgroundColor = UIColor.blackColor()
        case 2:
            cell.backgroundColor = UIColor.greenColor()
        default:
            cell.backgroundColor = UIColor.blueColor()
        }
        
        return cell
    }
}

extension SwiftLoopView: UICollectionViewDelegate {
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
    }
}

extension SwiftLoopView: UIScrollViewDelegate {
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        //
    }
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //
    }
}