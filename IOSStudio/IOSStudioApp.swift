import SwiftUI

@main
struct IOSStudioApp: App {
    @State private var viewModel = ViewModel()
    var feedback = Feedback()
    var scenarioOptions = ScenarioOptions()
    
    var body: some Scene {
        WindowGroup (id: "HomeView"){
            HomeView().environmentObject(scenarioOptions)
        }
        .defaultSize(CGSize(width: 400, height: 400))
        
        WindowGroup(id: "BriefView") {
            BriefView().environmentObject(scenarioOptions)
                .environment(viewModel)
        }
        .defaultSize(CGSize(width: 400, height: 400))
        
        WindowGroup (id: "ResponseView") {
            ResponseView().environmentObject(feedback)
                .environment(viewModel)
                .environmentObject(scenarioOptions)
        }
        .defaultSize(CGSize(width: 520, height: 400))
        
        WindowGroup (id: "FeedbackView") {
            FeedbackView().environmentObject(feedback)
        }
        .defaultSize(CGSize(width: 400, height: 400))
        
        ImmersiveSpace(id: "ImmersiveView") {
            ImmersiveView()
                .environment(viewModel)
        }
    }
}
