//
//  FeedbackView.swift
//  IOSStudio
//
//  Created by Lachlan Atack on 20/4/2024.
//

import SwiftUI

struct FeedbackView: View {
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @State var result: String
    
    var body: some View {
        Text(result)
            .font(.title)
            .multilineTextAlignment(.center)
            .padding()
        HStack {
            Button(action: {
                Task
                {
                    await dismissImmersiveSpace()
                    openWindow(id: "HomeView")
                    dismissWindow(id: "ResponseView")
                }
            }, label: {
                Image(systemName: "xmark.circle")
                    .frame(width: 30, height: 30)
            })
            Button(action: {
                openWindow(id: "ResponseView")
                dismissWindow(id: "FeedbackView")
            }, label: {
                Image(systemName: "gobackward")
                    .frame(width: 30, height: 30)
            })
        }
        .font(.title)
        .tint(.indigo)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    FeedbackView(result: "Pass")
}
