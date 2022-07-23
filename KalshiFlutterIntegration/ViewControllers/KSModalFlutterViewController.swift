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

class KSModalFlutterViewController: KSFlutterViewController {

    weak var listener: KSModalFlutterViewControllerListener?
    
    init() {
        super.init(entryPoint: "presentedMain")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        channel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "closeSelf" {
                self?.listener?.dimissFlutterVC()
                result(nil)
            } else if call.method == "openDrawer" {
                self?.listener?.openDrawer(animated: true)
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        })
    }
    
    private lazy var channel = FlutterMethodChannel(name: ProjectName, binaryMessenger: self.binaryMessenger)
}
