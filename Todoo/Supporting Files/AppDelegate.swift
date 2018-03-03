//
//  AppDelegate.swift
//  Todoo
//
//  Created by babu on 28/02/18.
//  Copyright © 2018 Bobzzzdev. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL)

        do {
            let realm = try Realm()

        } catch {
            print("Error initializing realm, \(error)")
        }
        
 
        
        return true
    }
}

