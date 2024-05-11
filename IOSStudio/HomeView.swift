import SwiftUI
import RealityKit
import RealityKitContent

struct HomeView: View {
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @EnvironmentObject var scenarioOptions: ScenarioOptions
    
    var body: some View {
        VStack {
            VStack {
                Text("ConversaCoach")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundStyle(.indigo)
                VStack {
                    
                    Text("Choose a scenario")
                        .font(.title2)
                    
                    Button(action: {
                        scenarioOptions.scenario = "Cafe"
                        openWindow(id: "BriefView")
                        dismissWindow(id: "HomeView")
                    }, label: {
                        Text("Ordering a Coffee")
                        Image(systemName: "cup.and.saucer.fill")
                    })
                    
                    Text("More scenarios coming soon!")
                        .padding()
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.indigo)
                
                Toggle(isOn: $scenarioOptions.captions) {
                    Text("Captions")
                }
                .frame(width: 200)
                .tint(.indigo)
            }
        }
        .onLoad {
            dismissWindow(id: "ResponseView")
            dismissWindow(id: "FeedbackView")
            dismissWindow(id: "BriefView")
        }
    }
}

#Preview(windowStyle: .automatic) {
    HomeView()
}
