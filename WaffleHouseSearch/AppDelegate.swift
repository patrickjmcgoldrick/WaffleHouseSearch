//
//  AppDelegate.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/9/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
               GMSServices.provideAPIKey("AIzaSyBKvkzNsaicGg9ijvV8fED0zLb-0_nDy9k")
        
        return true
    }
}
