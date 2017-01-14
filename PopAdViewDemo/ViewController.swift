//
//  ViewController.swift
//  PopAdView
//
//  Created by KingCQ on 2017/1/14.
//  Copyright © 2017年 KingCQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let adAlertview = ADAlertView(view: view, handle: { indexPath in
            print(indexPath, "🌹")
        }, close: { bool in
            
        })
        adAlertview.containerSubviews = [UIImage(named: "adimage")!]
        adAlertview.show()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

