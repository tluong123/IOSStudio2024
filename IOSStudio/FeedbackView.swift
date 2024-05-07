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
    
    @State var feedbackText = "Fail"
    
    @EnvironmentObject var feedback: Feedback
    
    var body: some View {
        Text(feedbackText)
            .font(.title)
            .padding()
        
        Text(feedback.feedback)
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
                dismissWindow(id: "FeedbackView")

            }, label: {
                Image(systemName: "gobackward")
                    .frame(width: 30, height: 30)
            })
        }
        .onLoad() {
            if feedback.passed {
                feedbackText = "Pass"
            }
        }
        .font(.title)
        .tint(.indigo)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    FeedbackView()
}
