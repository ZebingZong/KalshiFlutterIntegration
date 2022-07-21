//
//  KSModalFlutterViewController.swift
//  KalshiFlutterIntegration
//
//  Created by Andrew on 7/19/22.
//

import Flutter

protocol KSModalFlutterViewControllerListener: AnyObject {
    func openDrawer(animated: Bool)
    func dimissFlutterVC()
}

class KSModalFlutterViewController: FlutterViewController {

    weak var listener: KSModalFlutterViewControllerListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupKSDrawableLeftBarItem()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                            target: self,
                                                            action: #selector(closeSelf))
        navigationController?.navigationBar.barStyle = .default
    }
        
    @objc internal override func openKSLeftDrawer() {
        listener?.openDrawer(animated: true)
    }
    
    @objc private func closeSelf() {
        listener?.dimissFlutterVC()
    }
}
