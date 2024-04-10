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
            VStack {
//                Spacer()
                Text("ConversaCoach")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.indigo)
                VStack {
                    Text("Choose a scenario")
                        .font(.title2)
                    Button(action: {
                        Task
                        {
                            await openImmersiveSpace(id:"ImmersiveView")
                        }
                    }, label: {
                        Text("Ordering a Coffee")
                        
                        Image(systemName: "cup.and.saucer.fill")
                    })
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.indigo)
                Spacer()
                Toggle(isOn: /*@START_MENU_TOKEN@*/.constant(true)/*@END_MENU_TOKEN@*/, label: {
                    Text("Closed Captions")
                })
                .tint(.indigo)
                .padding(.horizontal, 500)
            }
            
//            Button("Open Immersive Space") {
//                Task
//                {
//                    await openImmersiveSpace(id:"ImmersiveView")
//                }
//            }
            
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
