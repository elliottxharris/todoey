//
//  AppDelegate.swift
//  todoey
//
//  Created by Elliott Harris on 1/9/19.
//  Copyright © 2019 Elliott. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		do {
			_ = try Realm()
		} catch {
			print("Error in Realm \(error)")
		}
		
		return true
	}

	func applicationWillTerminate(_ application: UIApplication) {
		
	}
}
