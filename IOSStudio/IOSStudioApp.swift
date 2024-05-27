import SwiftUI

@main
struct IOSStudioApp: App {
    @State private var viewModel = ViewModel()
    var feedback = Feedback()
    var scenarioOptions = ScenarioOptions()
    
    var body: some Scene {
        WindowGroup (id: "HomeView"){
            HomeView()
                .environmentObject(scenarioOptions)
                .frame(
                    minWidth: 400, maxWidth: 400,
                    minHeight: 400, maxHeight: 400)
        }
        .windowResizability(.contentSize)
        .defaultSize(CGSize(width: 400, height: 400))
        
        WindowGroup(id: "BriefView") {
            BriefView()
                .environmentObject(scenarioOptions)
                .environment(viewModel)
                .frame(
                    minWidth: 400, maxWidth: 400,
                    minHeight: 400, maxHeight: 400)
        }
        .windowResizability(.contentSize)
        .defaultSize(CGSize(width: 400, height: 400))
        
        WindowGroup (id: "ResponseView") {
            ResponseView().environmentObject(feedback)
                .environment(viewModel)
                .environmentObject(scenarioOptions)
                .frame(
                    minWidth: 520, maxWidth: 520,
                    minHeight: 400, maxHeight: 400)
        }
        .windowResizability(.contentSize)
        .defaultSize(CGSize(width: 520, height: 400))
        
        WindowGroup (id: "FeedbackView") {
            FeedbackView()
                .environmentObject(feedback)
                .frame(
                    minWidth: 400, maxWidth: 400,
                    minHeight: 400, maxHeight: 400)
        }
        .windowResizability(.contentSize)
        .defaultSize(CGSize(width: 400, height: 400))
        
        ImmersiveSpace(id: "ImmersiveView") {
            ImmersiveView()
                .environment(viewModel)
        }
    }
}
