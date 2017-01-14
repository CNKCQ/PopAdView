//
//  PopAdView.swift
//  PopAdView
//
//  Created by KingCQ on 2017/1/14.
//  Copyright © 2017年 KingCQ. All rights reserved.
//

import UIKit

class ADAlertView: UIView {
    var cardBgColor: UIColor?
    var closeBtnTintColor: UIColor?
    var closeBtnBgColor: UIColor?
    var cornerRadius: CGFloat?
    var dimBackground: Bool?
    var minHorizontalPadding: CGFloat?
    var minVertalPadding: CGFloat?
    var proportion: CGFloat?
    
    var containerSubviews = [UIImage]() {
        didSet {
            if Thread.isMainThread {
                performSelector(onMainThread: #selector(updateUIForKeypath), with: nil, waitUntilDone: false)
            } else {
                updateUIForKeypath()
            }
        }
    }
    
    private var selectedIndexPath: ((IndexPath) -> Void)?
    private var closeAction: ((Bool) -> Void)?
    
    private let containerView = ADAlertContainerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        alpha = 0
        backgroundColor = .clear
        closeBtnTintColor = .white
        cornerRadius = 10
        dimBackground = true
        minHorizontalPadding = frame.width * 0.1
        minVertalPadding = 10
        proportion = 0.75
        containerView.closeAction = {
            self.hide()
        }
        addSubview(containerView)
        NotificationCenter.default.addObserver(self, selector: #selector(statusBarOrientationDidChange), name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    convenience init(view: UIView, handle: ((IndexPath) -> Void)? = nil, close: ((Bool) -> Void)? = nil) {
        self.init(frame: view.bounds)
        view.addSubview(self)
        selectedIndexPath = handle
        closeAction = close
    }
    
    convenience init(window: UIWindow) {
        self.init(view: window)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
    }
    
    func show() {
        showUsingAnimation(true)
    }
    
    func hide() {
        if let close = closeAction {
            close(true)
        }
        hideUsingAnimation(true)
    }
    
    func showUsingAnimation(_ animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 1
            })
        } else {
            self.alpha = 1
        }
    }
    
    func hideUsingAnimation(_ animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 0
            })
        } else {
            alpha = 0
        }
    }
    
    func updateUIForKeypath() {
        containerView.contents = containerSubviews
        containerView.selected({ [unowned self] indexPath in
            if let selectedIndePath = self.selectedIndexPath {
                selectedIndePath(indexPath)
                self.hide()
            }
        })
        
        setNeedsLayout()
        setNeedsDisplay()
        
        for subView in subviews {
            subView.setNeedsLayout()
            subView.setNeedsDisplay()
        }
    }
    
    func statusBarOrientationDidChange(_ notification: Foundation.Notification) {
        if let superview = superview {
            frame = superview.bounds
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        if dimBackground! {
            let context = UIGraphicsGetCurrentContext()
            context!.setFillColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.65).cgColor)
            context!.fill(rect)
        }
    }
    
    override func layoutSubviews() {
        containerView.containerBgColor = cardBgColor
        containerView.closeBtnBgColor = closeBtnBgColor
        containerView.closeBtnTintColor = closeBtnTintColor
        containerView.cornerRadius = cornerRadius
        
        if bounds.width > bounds.height {
            let containerHeight = bounds.height - minVertalPadding! * 2
            containerView.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: containerHeight * proportion!, height: containerHeight))
        } else {
            let containerWidth = bounds.width - minHorizontalPadding! * 2
            containerView.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: containerWidth, height: containerWidth / proportion! + 78))
        }
        containerView.center = CGPoint(x: bounds.midX, y: bounds.midY - 39)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

