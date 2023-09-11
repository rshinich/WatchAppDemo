//
//  ControlControlView.swift
//  WatchApp-Watch Watch App
//
//  Created by 张忠瑞 on 2023/9/4.
//

import SwiftUI

struct ControlControlView: View {
    var body: some View {

        VStack {
            HStack {
                Text("                 ")
                Button {

                } label: {
                    Image(systemName: "chevron.up")
                }
                Text("                 ")
            }
            HStack {
                Button {

                } label: {
                    Image(systemName: "chevron.left")
                }
                Button {

                } label: {
                    Image(systemName: "circle.fill")
                }
                Button {

                } label: {
                    Image(systemName: "chevron.right")
                }
            }

            HStack {
                Text("                 ")
                Button {

                } label: {
                    Image(systemName: "chevron.down")
                }
                Text("                 ")
            }

        }

    }
}

struct ControlControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlControlView()
    }
}
