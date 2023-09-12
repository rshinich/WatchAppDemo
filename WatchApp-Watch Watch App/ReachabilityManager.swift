//
//  ReachabilityManager.swift
//  WatchApp-Watch Watch App
//
//  Created by 张忠瑞 on 2023/9/12.
//

import Foundation
import WatchConnectivity

class ReachabilityManager: ObservableObject {

    @Published var isReachable: Bool = false

    init() {
        self.addNotification()
    }

    public func sendMsg() {

        self.sendMessage(["Test": "from watch"])
    }

    // MARK: -

    private func sendMessage(_ message: [String: Any]) {

        guard WCSession.default.activationState == .activated else {
            return
//            return handleSessionUnactivated(with: commandStatus)
        }

        WCSession.default.sendMessage(message, replyHandler: { replyMessage in
            print("replyMessage=\(replyMessage)")
        }, errorHandler: { error in
            print("sendMessage error=\(error)")
        })
    }


    // MARK: -

    private func addNotification() {

        NotificationCenter.default.addObserver(
            self, selector: #selector(type(of: self).activationDidComplete(_:)),
            name: .activationDidComplete, object: nil
        )

        NotificationCenter.default.addObserver(
            self, selector: #selector(type(of: self).reachabilityDidChange(_:)),
            name: .reachabilityDidChange, object: nil
        )

    }

    @objc func activationDidComplete(_ notification: Notification) {
        updateReachability()
    }

    // .reachabilityDidChange notification handler.
    //
    @objc func reachabilityDidChange(_ notification: Notification) {
        updateReachability()
    }

    private func updateReachability() {

        var isReachable = false
        if WCSession.default.activationState == .activated {
            isReachable = WCSession.default.isReachable
        }
        self.isReachable = isReachable
    }
}
