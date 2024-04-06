//
//  ContentView.swift
//  Week7
//
//  Created by Avinash Singh on 2/4/2024.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        VStack {
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)

            Text("Hello, world!")
            Button("Open Immersive Space") {
                Task
                {
                    await openImmersiveSpace(id:"fullImmersiveView")
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
