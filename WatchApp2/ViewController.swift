//
//  ViewController.swift
//  WatchApp
//
//  Created by 张忠瑞 on 2023/8/30.
//

import UIKit
import WatchConnectivity


class ViewController: UIViewController {

    let reachableLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addNotification()

        self.view.addSubview(self.reachableLabel)
        self.reachableLabel.text = "reachable"
        self.reachableLabel.textColor = .white
        self.reachableLabel.textAlignment = .center
        self.reachableLabel.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200)

        let goBtn = UIButton.init(type: .custom)
        goBtn.setTitle("Go", for: .normal)
        goBtn.setTitleColor(.blue, for: .normal)
        goBtn.addTarget(self, action: #selector(goBtnClicked), for: .touchUpInside)
        goBtn.frame = CGRect(x: 0, y: 200, width: self.view.bounds.width, height: 200)
        self.view.addSubview(goBtn)

        let sendMsgBtn = UIButton.init(type: .custom)
        sendMsgBtn.setTitle("Send Msg", for: .normal)
        sendMsgBtn.setTitleColor(.blue, for: .normal)
        sendMsgBtn.addTarget(self, action: #selector(sendMsgBtnClicked), for: .touchUpInside)
        sendMsgBtn.frame = CGRect(x: 0, y: 400, width: self.view.bounds.width, height: 200)
        self.view.addSubview(sendMsgBtn)
    }

    @objc func goBtnClicked() {
        self.present(CameraViewController(), animated: true)
    }

    @objc func sendMsgBtnClicked() {
        self.sendMessage(["Test": "asdkashkd"])
    }

    // MARK: - Message

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

    // MARK: - Status

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
        updateReachabilityColor()
    }

    // .reachabilityDidChange notification handler.
    //
    @objc func reachabilityDidChange(_ notification: Notification) {
        updateReachabilityColor()
    }

    private func updateReachabilityColor() {
        // WCSession.isReachable triggers a warning if the session isn't in .activated state.
        //
        var isReachable = false
        if WCSession.default.activationState == .activated {
            isReachable = WCSession.default.isReachable
        }
        self.reachableLabel.backgroundColor = isReachable ? .green : .red
    }

}

