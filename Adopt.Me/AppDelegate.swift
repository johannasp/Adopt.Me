//
//  AppDelegate.swift
//  Adopt.Me
//
//  Created by Johanna Smith-Palliser on 1/28/17.
//  Copyright © 2017 Johanna Smith-Palliser. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        //window?.rootViewController = TinderFeedViewController()
        window?.rootViewController = UINavigationController(rootViewController: TinderFeedViewController())
        window?.makeKeyAndVisible()
        
        return true
    }


}

