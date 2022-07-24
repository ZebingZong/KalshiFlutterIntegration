//
//  KSTabHomeViewController.swift
//  KalshiFlutterIntegration
//
//  Created by Andrew on 7/17/22.
//

import UIKit
import Flutter

protocol KSTabHomeViewControllerListener: AnyObject {
    func openDrawer(animated: Bool)
    func presentFlutterVC()
}

class KSTabHomeViewController: UIViewController {

    weak var listener: KSTabHomeViewControllerListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    // MAKR: - Private
    
    private func setupUI() {
        view.backgroundColor = .systemCyan
        setupKSDrawableLeftBarItem()
        view.addSubview(openButton)
    }
    
    private func setupConstraints() {
        openButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        openButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc internal override func openKSLeftDrawer() {
        listener?.openDrawer(animated: true)
    }
    
    private lazy var openButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.buttonSize = .medium
        
        let button = UIButton(type: .custom)
        button.configuration = config
        let action = UIAction { [weak self] _ in
            self?.listener?.presentFlutterVC()
        }
        button.addAction(action, for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.setTitle("Open Flutter", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}
