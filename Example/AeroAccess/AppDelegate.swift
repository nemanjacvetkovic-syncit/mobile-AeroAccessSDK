//
//  AppDelegate.swift
//  AeroAccess
//
//  Created by nemanjacvetkovic-syncit on 11/29/2023.
//  Copyright (c) 2023 nemanjacvetkovic-syncit. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var backgroundTask: UIBackgroundTaskIdentifier?
    var viewModel: ViewModel?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let options: UNAuthorizationOptions = [.badge, .sound, .alert]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { _, error in
            if let error = error {
                debugPrint("Error: \(error)")
            }
        }
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let isLocalNotification = userInfo["isLocalNotification"] as? Bool {
            if isLocalNotification {
                startBackgroundTask()
            }
        }
        debugPrint("UserInfo: \(userInfo)")
    }
}

extension AppDelegate {
    func startBackgroundTask() {
        self.stopBackgroundTask()
        backgroundTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            self.stopBackgroundTask()
        })
        
        DispatchQueue.main.async {
            self.configureAndStartAeroAccessService()
        }
    }
    
    func stopBackgroundTask() {
        guard let backgroundTask = backgroundTask else { return }
        if backgroundTask != UIBackgroundTaskIdentifier.invalid {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            self.backgroundTask = UIBackgroundTaskIdentifier.invalid
        }
    }
}

extension AppDelegate {
    func configureAndStartAeroAccessService() {
        self.viewModel = ViewModel()
        viewModel?.start()
        debugPrint(">>> AeroAccess Service Started ...")
    }
}
