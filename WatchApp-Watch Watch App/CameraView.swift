//
//  CameraView.swift
//  WatchApp-Watch Watch App
//
//  Created by 张忠瑞 on 2023/9/12.
//

import SwiftUI

struct CameraView: View {

    @StateObject var testModel = TestModel()

    var body: some View {
        Image(uiImage: testModel.image ?? UIImage.init())
            .resizable()
            .scaledToFit()
            .rotationEffect(.degrees(90))

    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
