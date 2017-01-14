//
//  ADAlertContainerView.swift
//  PopAdView
//
//  Created by KingCQ on 2017/1/14.
//  Copyright © 2017年 KingCQ. All rights reserved.
//

import UIKit

// MARK: - ADAlertContainerView
class ADAlertContainerView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    var cornerRadius: CGFloat?
    var containerBgColor: UIColor?
    var closeBtnTintColor: UIColor?
    var closeBtnBgColor: UIColor?
    var contents = [UIImage]()
    var closeAction: (() -> ())?
    
    private let closeBtn = ADAlertCloseButton()
    private let containerView = UIView()
    private let layout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView!
    private var selectedIndexPath: ((IndexPath) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ADCell.self, forCellWithReuseIdentifier: "cell_id")
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        
        closeBtn.buttonStrokeColor = closeBtnTintColor
        closeBtn.backgroundColor = .clear
        closeBtn.addTarget(superview, action: #selector(close), for: .touchUpInside)
        
        if let cornerRadius = cornerRadius {
            containerView.layer.cornerRadius = cornerRadius
        }
        
        containerView.backgroundColor = containerBgColor
        containerView.layer.masksToBounds = true
        containerView.addSubview(collectionView)
        
        addSubview(containerView)
        addSubview(closeBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let kCloseButtonWidth: CGFloat = 24
        let lengthen: CGFloat = 15
        containerView.frame = bounds
        containerView.layer.cornerRadius = cornerRadius!
        
        closeBtn.buttonStrokeColor = closeBtnTintColor
        closeBtn.backgroundColor = closeBtnBgColor
        closeBtn.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: kCloseButtonWidth, height: kCloseButtonWidth))
        closeBtn.frame.origin = CGPoint(x: (containerView.frame.maxX - kCloseButtonWidth) / 2, y: containerView.frame.maxY - kCloseButtonWidth)
        closeBtn.setNeedsDisplay()
        
        collectionView.frame = containerView.bounds.insetBy(dx: 0, dy: kCloseButtonWidth + lengthen)
        layout.itemSize = collectionView.frame.size
        collectionView.reloadData()
        collectionView.contentOffset = CGPoint.zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_id", for: indexPath)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let adCell = cell as? ADCell
        adCell?.imageView.image = contents[(indexPath as NSIndexPath).row]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedIndexPath = selectedIndexPath {
            selectedIndexPath(indexPath)
        }
    }
    
    func selected(_ item: @escaping ((IndexPath) -> Void)) {
        selectedIndexPath = item
    }
    
    func close() {
        closeAction?()
    }
}
