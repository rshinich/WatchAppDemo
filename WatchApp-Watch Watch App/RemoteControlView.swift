//
//  RemoteControlView.swift
//  WatchApp-Watch Watch App
//
//  Created by 张忠瑞 on 2023/9/11.
//

import SwiftUI

struct RemoteControlView: View {

    @State private var isShowingVideo = false
    @State private var isShowingPhoto = false
    @State private var isShowingClick = false
    @State private var isShowingControl = false


    var body: some View {
        NavigationView {
            List {

                NavigationLink("Video", isActive: $isShowingVideo) {

                    VideoControlView()

                }

                NavigationLink("Photo", isActive: $isShowingPhoto) {

                    PhotoControlView()

                }

                NavigationLink("Click", isActive: $isShowingClick) {

                    ClickControlView()

                }

                NavigationLink("Control", isActive: $isShowingControl) {

                    ControlControlView()
                }


            }
        }
    }
}

struct RemoteControlView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteControlView()
    }
}
