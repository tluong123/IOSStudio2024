import SwiftUI
import RealityKit
import RealityKitContent

struct HomeView: View {
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        VStack {
            Model3D(named: "Immersive", bundle: realityKitContentBundle)
                .padding(.bottom, 50)
            VStack {
                Text("ConversaCoach")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundStyle(.indigo)
                VStack {
                    Text("Choose a scenario")
                        .font(.title2)
                    Button(action: {
                        //                        dismissWindow(id: "HomeView")
                        openWindow(id: "ResponseView")
                        Task
                        {
                            await openImmersiveSpace(id:"ImmersiveView")
                            dismissWindow(id: "HomeView")
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
                ///               Toggle(isOn: /*@START_MENU_TOKEN@*/.constant(true)/*@END_MENU_TOKEN@*/, label: {
                //                    Text("Closed Captions")
                //                })
                //                .tint(.indigo)
                //                .padding(.horizontal, 500)
            }
            
            //            Button("Open Immersive Space") {
            //                Task
            //                {
            //                    await openImmersiveSpace(id:"ImmersiveView")
            //                }
            //            }
            //
            //            Button("Close Immersive Space") {
            //                Task
            //                {
            //                    await dismissImmersiveSpace()
            //                }
            //            }
        }
        .onLoad {
            dismissWindow(id: "ResponseView")
            dismissWindow(id: "FeedbackViewPass")
            dismissWindow(id: "FeedbackViewFail")
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    HomeView()
}
