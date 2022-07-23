//
//  KSFlutterViewController.swift
//  KalshiFlutterIntegration
//
//  Created by Andrew on 7/23/22.
//

import Flutter
import FlutterPluginRegistrant

let ProjectName = "kalshi-flutter-integration"

class KSFlutterViewController: FlutterViewController {
    
    init(entryPoint: String? = nil) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("The shared app delegate must be of type AppDelegate")
        }
        let flutterEngine = appDelegate.flutterEngines.makeEngine(withEntrypoint: entryPoint, libraryURI: nil)
        GeneratedPluginRegistrant.register(with: flutterEngine)
        super.init(engine: flutterEngine, nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


