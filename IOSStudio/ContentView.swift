import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        VStack {
           Model3D(named: "Immersive", bundle: realityKitContentBundle)
                .padding(.bottom, 50)

            Text("Hello, world!")
            Button("Open Immersive Space") {
                Task
                {
                    await openImmersiveSpace(id:"ImmersiveView")
                }
            }
            
            Button("Close Immersive Space") {
                
                Task
                {
                    await dismissImmersiveSpace()
                }
            }
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
