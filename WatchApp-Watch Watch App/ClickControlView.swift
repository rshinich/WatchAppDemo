//
//  ClickControlView.swift
//  WatchApp-Watch Watch App
//
//  Created by 张忠瑞 on 2023/9/4.
//

import SwiftUI

struct ClickControlView: View {
    var body: some View {
        VStack {
            Text("Click")

            Spacer()

            Button {

            } label: {
                Image(systemName: "dot.circle.and.hand.point.up.left.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.white)

            }
            .buttonStyle(.plain)
            .controlSize(.large)

        }
    }
}

struct ClickControlView_Previews: PreviewProvider {
    static var previews: some View {
        ClickControlView()
    }
}
