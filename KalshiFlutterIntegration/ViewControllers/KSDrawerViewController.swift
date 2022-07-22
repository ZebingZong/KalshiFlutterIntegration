//
//  KSDrawerViewController.swift
//  KalshiFlutterIntegration
//
//  Created by Andrew on 7/17/22.
//

import Foundation
import UIKit
import Flutter

protocol KSDrawerViewControllerListener: AnyObject {
    func presentFlutterVC()
    func dimissFlutterVC()
    func closeDrawer(animated: Bool)
}

class KSDrawerViewController: UIViewController, KSDrawerPresentable {
    
    weak var listener: KSDrawerViewControllerListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    override func updateViewConstraints() {
        setHamburgerButtonTopConstraint()
        super.updateViewConstraints()
    }
    
    // MARK: - KSDrawerPresentable
    
    func updateButtonState(isPresentingFlutterVC: Bool) {
        openButton.isEnabled = !isPresentingFlutterVC
        closeButton.isEnabled = isPresentingFlutterVC
    }
    
    // MARK: - Private
    private var hamburgerButtonTopConstraint: NSLayoutConstraint?
    
    private lazy var hamburgerButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "hamburgerIcon")

        let button = UIButton(type: .system)
        button.configuration = config
        let action = UIAction { [weak self] _ in
            self?.closeSelf()
        }
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var openButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.buttonSize = .medium
                
        let button = UIButton(type: .custom)
        button.configuration = config
        let action = UIAction { [weak self] _ in
            self?.openFlutterVC()
        }
        button.addAction(action, for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.setTitle("Open Flutter", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.buttonSize = .medium
                
        let button = UIButton(type: .custom)
        button.configuration = config
        let action = UIAction { [weak self] _ in
            self?.closeFlutterVC()
        }
        button.addAction(action, for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.setTitle("Close Flutter", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6.0
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemCyan
        view.addSubview(hamburgerButton)
        view.addSubview(openButton)
        view.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        setHamburgerButtonTopConstraint()
        hamburgerButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        hamburgerButton.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        hamburgerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0).isActive = true
        openButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        openButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200.0).isActive = true
        closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        closeButton.topAnchor.constraint(equalTo: openButton.bottomAnchor, constant: 50.0).isActive = true
    }
    
    private func setHamburgerButtonTopConstraint() {
        hamburgerButtonTopConstraint?.isActive = false
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 47.0
        hamburgerButtonTopConstraint = hamburgerButton.topAnchor.constraint(equalTo: view.topAnchor,
                                                                            constant: statusBarHeight)
        hamburgerButtonTopConstraint?.isActive = true
    }
    
    private func openFlutterVC() {
        listener?.closeDrawer(animated: false)
        listener?.presentFlutterVC()
    }
    
    private func closeFlutterVC() {
        listener?.closeDrawer(animated: false)
        listener?.dimissFlutterVC()
    }
    
    @objc private func closeSelf() {
        listener?.closeDrawer(animated: true)
    }
}
