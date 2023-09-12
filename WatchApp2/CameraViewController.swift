//
//  CameraViewController.swift
//  WatchApp
//
//  Created by 张忠瑞 on 2023/8/26.
//

import UIKit
import AVKit
import WatchConnectivity

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    var session: AVCaptureSession = AVCaptureSession.init()
    var postCameraBuffer: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addNotification()
        self.updateReachability()
        self.setPreviewLayer()
        self.startRun()

        let queue = DispatchQueue.init(label: "com.demo.camrea")

        queue.async {
            self.session.startRunning()
        }

    }

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
        // WCSession.isReachable triggers a warning if the session isn't in .activated state.
        //
        var isReachable = false
        if WCSession.default.activationState == .activated {
            isReachable = WCSession.default.isReachable
        }

        self.postCameraBuffer = isReachable
    }



    private func startRun() {

        let devices = AVCaptureDevice.devices()

        guard let backDevice = devices.first(where: { $0.position == .back }) else {
            print("No back device")
            return
        }

        guard let deviceInput = try? AVCaptureDeviceInput(device: backDevice) else {
            print("No back device input")
            return
        }

        // input device is deviceInput

        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue.global())

        // output device is


        self.session.addInput(deviceInput)
        self.session.addOutput(output)


    }

    private func setPreviewLayer() {

        let previewLayer = AVCaptureVideoPreviewLayer.init(session: self.session)
        previewLayer.frame = self.view.bounds
        self.view.layer.addSublayer(previewLayer)

    }

    // MARK: - send msg data

    func sendMsgData(_ data: Data) {

        guard WCSession.default.activationState == .activated else {
            return
//            return handleSessionUnactivated(with: commandStatus)
        }

//        WCSession.default.sendMessageData(data) { replyMessageData in
//
//            print("replyMessageData=\(replyMessageData)")
//        }

        WCSession.default.sendMessageData(data, replyHandler: nil)

    }

    // MARK: -

    var sendMsgDataCount: Int = 0

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {


        guard self.postCameraBuffer else { return }

        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        let ciimage = CIImage(cvPixelBuffer: imageBuffer)
        let image = self.convert(cmage: ciimage)

        let resizeImage = self.resize(image: image, targetSize: CGSize(width: 50, height: 50))

//        print("zzr+++\(resizeImage)")
        if let data = resizeImage.jpegData(compressionQuality: 0.5) {
            print("zzr+++\(data.count)")

//            sendMsgDataCount += 1

//            if sendMsgDataCount == 5 {
//                sendMsgDataCount = 0
                self.sendMsgData(data)
//            }
        }
    }

    func convert(cmage: CIImage) -> UIImage {
         let context = CIContext(options: nil)
         let cgImage = context.createCGImage(cmage, from: cmage.extent)!
         let image = UIImage(cgImage: cgImage)
         return image
    }

    func resize(image: UIImage, targetSize: CGSize) -> UIImage {

        // Compute the scaling ratio for the width and height separately
        let widthScaleRatio = targetSize.width / image.size.width
        let heightScaleRatio = targetSize.height / image.size.height

        // To keep the aspect ratio, scale by the smaller scaling ratio
        let scaleFactor = min(widthScaleRatio, heightScaleRatio)

        // Multiply the original image’s dimensions by the scale factor
        // to determine the scaled image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: image.size.width * scaleFactor,
            height: image.size.height * scaleFactor
        )

        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        let scaledImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        }

        return scaledImage

    }
}
