//
//  KSRootTabBarController.swift
//  KalshiFlutterIntegration
//
//  Created by Andrew on 7/17/22.
//

import Foundation
import UIKit

protocol KSDrawerPresentable {
    func updateButtonState(isPresentingFlutterVC: Bool)
}

class KSRootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresentingContainer()
        setupDrawer()
        setupTabBar()
    }
    
    // MARK: - Private
    
    private let drawerAnimationTime = 0.3
    private let drawerHeight = UIScreen.main.bounds.height
    private let drawerWidth = UIScreen.main.bounds.width / 3.0 * 2.0
    
    private lazy var presentingContainer: UIViewController = {
        let container = UIViewController()
        container.view.backgroundColor = .clear
        container.view.isUserInteractionEnabled = false
        container.definesPresentationContext = true
        return container
    }()
    
    private lazy var drawerVC: KSDrawerViewController = {
        let drawerVC = KSDrawerViewController()
        drawerVC.listener = self
        drawerVC.view.frame = CGRect(origin: CGPoint(x: -drawerWidth, y: 0),
                                     size: CGSize(width: drawerWidth, height: drawerHeight))
        return drawerVC
    }()
    
    private func setupPresentingContainer() {
        addChild(presentingContainer)
        view.addSubview(presentingContainer.view)
        presentingContainer.didMove(toParent: self)
        
        presentingContainer.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        presentingContainer.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        presentingContainer.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        presentingContainer.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupDrawer() {
        addChild(drawerVC)
        view.addSubview(drawerVC.view)
        drawerVC.didMove(toParent: self)
    }
    
    private func setupTabBar() {
        let homeItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        let tabHomeVC = KSTabHomeViewController()
        tabHomeVC.tabBarItem = homeItem
        tabHomeVC.listener = self
        let firstVC = UINavigationController(rootViewController: tabHomeVC)
        
        let flutterItem = UITabBarItem(tabBarSystemItem: .recents, tag: 1)
        let tabFlutterVC = KSTabFlutterViewController()
        tabFlutterVC.tabBarItem = flutterItem
        tabFlutterVC.listener = self
        let secondVC = UINavigationController(rootViewController: tabFlutterVC)
        
        viewControllers = [firstVC, secondVC]
    }
}

extension KSRootTabBarController: KSDrawerViewControllerListener {
    
    func presentFlutterVC() {
        guard let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine else {
            return
        }
        
        let flutterVC = KSModalFlutterViewController(engine: flutterEngine,
                                                     nibName: nil,
                                                     bundle: nil)
        flutterVC.listener = self
        let presentedVC = UINavigationController(rootViewController: flutterVC)
        presentedVC.modalPresentationStyle = .overCurrentContext
        presentingContainer.present(presentedVC, animated: true, completion: nil)
        drawerVC.updateButtonState(isPresentingFlutterVC: true)
    }
    
    func dimissFlutterVC() {
        presentingContainer.dismiss(animated: true)
        drawerVC.updateButtonState(isPresentingFlutterVC: false)
    }
    
    func closeDrawer(animated: Bool) {
        UIView.animate(withDuration: animated ? drawerAnimationTime * 1.5 : 0) {
            self.drawerVC.view.transform.tx = -self.drawerWidth
        }
    }
}

extension KSRootTabBarController: KSModalFlutterViewControllerListener {
    
    func openDrawer(animated: Bool) {
        UIView.animate(withDuration: animated ? drawerAnimationTime : 0) {
            self.drawerVC.view.transform.tx = self.drawerWidth
        }
    }
}

extension KSRootTabBarController: KSTabHomeViewControllerListener, KSTabFlutterViewControllerListener {}
