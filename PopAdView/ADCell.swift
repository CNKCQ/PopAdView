//
//  ADCell.swift
//  PopAdView
//
//  Created by KingCQ on 2017/1/14.
//  Copyright © 2017年 KingCQ. All rights reserved.
//

import UIKit

// MARK: - ADAlertCloseButton
class ADAlertCloseButton: UIButton {
    var buttonStrokeColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackgroundImage(UIImage(named: "ic_ad_close"), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ADCell: UICollectionViewCell {
    let imageView = UIImageView()
    let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = CGRect(origin: CGPoint.zero, size: frame.size)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        clipsToBounds = true
        contentView.addSubview(imageView)
        
        textLabel.frame = CGRect(x: (frame.width - 40) / 2, y: 50, width: 40, height: 20)
        contentView.addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
