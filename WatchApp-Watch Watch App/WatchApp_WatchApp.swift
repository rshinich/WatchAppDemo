//
//  WatchApp_WatchApp.swift
//  WatchApp-Watch Watch App
//
//  Created by 张忠瑞 on 2023/9/8.
//

import SwiftUI
import WatchConnectivity

//https://developer.apple.com/documentation/watchkit/wkapplicationdelegate
class MyWatchAppDelegate: NSObject, WKApplicationDelegate {

    private lazy var sessionDelegator: SessionDelegator = {
        return SessionDelegator()
    }()

    func applicationDidBecomeActive() {
        print("[MyWatchAppDelegate] applicationDidBecomeActive")
    }

    func applicationWillResignActive() {
        print("[MyWatchAppDelegate] applicationWillResignActive")

    }

    func applicationDidEnterBackground() {
        print("[MyWatchAppDelegate] applicationDidEnterBackground")

    }

    func applicationDidFinishLaunching() {
        setupDelegate()
        print("[MyWatchAppDelegate] applicationDidFinishLaunching")

    }

    func applicationWillEnterForeground() {
        print("[MyWatchAppDelegate] applicationWillEnterForeground")

    }

    private func setupDelegate() {

        assert(WCSession.isSupported(), "This sample requires Watch Connectivity support!")
        WCSession.default.delegate = sessionDelegator
        WCSession.default.activate()
    }


}
@main
struct WatchApp_Watch_Watch_AppApp: App {

    @WKApplicationDelegateAdaptor var appDelegate: MyWatchAppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
