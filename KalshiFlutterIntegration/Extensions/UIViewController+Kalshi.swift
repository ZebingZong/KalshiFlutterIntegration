//
//  UIViewController+Kalshi.swift
//  KalshiFlutterIntegration
//
//  Created by Andrew on 7/19/22.
//

import UIKit

protocol KSViewControllerDrawable {
    func setupKSDrawableLeftBarItem()
    func openKSLeftDrawer()
}

extension UIViewController: KSViewControllerDrawable {
    func setupKSDrawableLeftBarItem() {
        title = "Add to App"
        let image = UIImage(named: "hamburgerIcon")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(openKSLeftDrawer))
    }
    
    @objc func openKSLeftDrawer() {
        fatalError("need to impment this function")
    }
}
