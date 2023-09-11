//
//  SessionDelegator.swift
//  WatchApp-Watch Watch App
//
//  Created by 张忠瑞 on 2023/9/5.
//

import Foundation
import WatchConnectivity

extension Notification.Name {
    static let activationDidComplete = Notification.Name("ActivationDidComplete")
    static let reachabilityDidChange = Notification.Name("ReachabilityDidChange")

    static let didReceiveMessage = Notification.Name("DidReceiveMessage")
    static let didReceiveMessageData = Notification.Name("DidReceiveMessageData")
}

class SessionDelegator: NSObject, WCSessionDelegate {

    //MARK: - Life cycle - Watch

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        postNotificationOnMainQueueAsync(name: .activationDidComplete)
    }

    func sessionReachabilityDidChange(_ session: WCSession) {
        postNotificationOnMainQueueAsync(name: .reachabilityDidChange)
    }

    // MARK: - Life cycle - iPhone

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }

    func sessionDidDeactivate(_ session: WCSession) {
        // Activate the new session after having switched to a new watch.
        session.activate()
    }

    func sessionWatchStateDidChange(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    #endif


    private func postNotificationOnMainQueueAsync(name: NSNotification.Name, object: Any? = nil) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: name, object: object)
        }
    }

    // MARK: - Message

    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        print("message111=\(message)")
        postNotificationOnMainQueueAsync(name: .didReceiveMessage, object: message)

    }

    func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {

        print("message222=\(message)")
        postNotificationOnMainQueueAsync(name: .didReceiveMessage, object: message)
    }

    // MARK: - Message Data

    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {

        print("messageData111=\(messageData)")
        postNotificationOnMainQueueAsync(name: .didReceiveMessageData, object: messageData)

    }

    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {

        print("messageData222=\(messageData)")
        postNotificationOnMainQueueAsync(name: .didReceiveMessageData, object: messageData)

    }


}
