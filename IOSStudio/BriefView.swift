import SwiftUI

struct BriefView: View {
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @EnvironmentObject var scenarioOptions: ScenarioOptions
    
    var body: some View {
        VStack {
            Text("Your Brief")
                .font(.title)
            
            if (scenarioOptions.scenario == "Cafe") {
                Text("Order a latte on a budget of $4.50")
                    .padding()
                    .multilineTextAlignment(.center)
            }
            HStack {
                Button(action: {
                    Task
                    {
                        openWindow(id: "HomeView")
                        dismissWindow(id: "BriefView")
                    }
                }, label: {
                    Image(systemName: "xmark.circle")
                        .frame(width: 30, height: 30)
                })
                Button(action: {
                    Task
                    {
                        await openImmersiveSpace(id:"ImmersiveView")
                        openWindow(id: "ResponseView")
                        dismissWindow(id: "BriefView")
                    }
                    
                }, label: {
                    Image(systemName: "arrowshape.right.circle")
                        .frame(width: 30, height: 30)
                })
            }
        }
        
        .tint(.indigo)
        .buttonStyle(.borderedProminent)
        .onLoad {
            dismissWindow(id: "HomeView")
        }
        
    }
}

#Preview {
    BriefView()
}
