//
//  TestModel.swift
//  WatchApp-Watch Watch App
//
//  Created by 张忠瑞 on 2023/9/12.
//

import Foundation
import UIKit

class TestModel: ObservableObject {

    @Published var content = "xxx"

    @Published var image: UIImage? = nil


    init() {

        self.addNotification()
    }

    private func addNotification() {

        NotificationCenter.default.addObserver(
            self, selector: #selector(type(of: self).didReceiveMessage(_:)),
            name: .didReceiveMessage, object: nil
        )

        NotificationCenter.default.addObserver(
            self, selector: #selector(type(of: self).didReceiveMessageData(_:)),
            name: .didReceiveMessageData, object: nil
        )


    }

    @objc func didReceiveMessage(_ notification: Notification) {

        guard let object = notification.object as? [String: Any] else { return }

        print("object = \(object)")

        for xx in object {
            self.content = xx.key
        }
    }

    @objc func didReceiveMessageData(_ notification: Notification) {

        guard let data = notification.object as? Data else { return }

        guard let image = UIImage(data: data) else { return }

        self.image = image
    }

}
