//
//  PhotoControlView.swift
//  WatchApp-Watch Watch App
//
//  Created by 张忠瑞 on 2023/9/4.
//

import SwiftUI

struct PhotoControlView: View {
    var body: some View {

        VStack {
            Text("Photo")

            Spacer()

            Button {

            } label: {
                Image(systemName: "camera.shutter.button.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.white)
            }
            .buttonStyle(.plain)
            .controlSize(.large)
        }

    }
}

struct PhotoControlView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoControlView()
    }
}
