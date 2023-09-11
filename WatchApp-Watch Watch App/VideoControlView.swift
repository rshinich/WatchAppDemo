//
//  VideoControlView.swift
//  WatchApp-Watch Watch App
//
//  Created by 张忠瑞 on 2023/9/4.
//

import SwiftUI

struct VideoControlView: View {
    var body: some View {

        VStack {
            Text("Video")

            Spacer()
            
            Button {

            } label: {
                Image(systemName: "record.circle")
                    .font(.system(size: 60))
                    .foregroundColor(.red)
            }
            .buttonStyle(.plain)
            .controlSize(.large)
        }

    }
}

struct VideoControlView_Previews: PreviewProvider {
    static var previews: some View {
        VideoControlView()
    }
}
