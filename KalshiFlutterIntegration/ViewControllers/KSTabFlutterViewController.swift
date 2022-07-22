//
//  KSTabFlutterViewController.swift
//  KalshiFlutterIntegration
//
//  Created by Andrew on 7/17/22.
//

import Foundation
import UIKit
import Flutter

protocol KSTabFlutterViewControllerListener: AnyObject {
    func openDrawer(animated: Bool)
}

class KSTabFlutterViewController: FlutterViewController {
    
    var listener: KSTabFlutterViewControllerListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKSDrawableLeftBarItem()
    }
        
    @objc internal override func openKSLeftDrawer() {
        listener?.openDrawer(animated: true)
    }
}
