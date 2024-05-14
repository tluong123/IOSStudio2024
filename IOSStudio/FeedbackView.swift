import SwiftUI

struct FeedbackView: View {
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    
    @State var feedbackText = "Fail"
    
    @EnvironmentObject var feedback: Feedback
    
    var body: some View {
        VStack {
            Text(feedbackText)
                .font(.title)
                .padding()
            
            Text(feedback.feedback)
                .multilineTextAlignment(.center)
                .padding()
            
            HStack {
                Button(action: {
                    openWindow(id: "HomeView")
                    dismissWindow(id: "FeedbackView")
                }, label: {
                    Image(systemName: "xmark.circle")
                        .frame(width: 30, height: 30)
                })
                Button(action: {
                    Task
                    {
                        await openImmersiveSpace(id:"ImmersiveView")
                        openWindow(id: "ResponseView")
                        dismissWindow(id: "FeedbackView")
                    }
                }, label: {
                    Image(systemName: "gobackward")
                        .frame(width: 30, height: 30)
                })
            }
            .onLoad() {
                dismissWindow(id: "ResponseView")
                if feedback.passed {
                    feedbackText = "Pass"
                }
            }
            .font(.title)
            .tint(.indigo)
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    FeedbackView()
}
