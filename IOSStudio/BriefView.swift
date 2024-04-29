//
//  BriefView.swift
//  IOSStudio
//
//  Created by Lachlan Atack on 29/4/2024.
//

import SwiftUI

struct BriefView: View {
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @State var scenario: String
    
    var body: some View {
        Text("Your Brief")
        .font(.title)
        
        if (scenario == "Cafe") {
            Text("Order a latte on a budget of $4.50")
                .padding()
        }
            
        HStack {
            Button(action: {
                Task
                {
                    await dismissImmersiveSpace()
                    openWindow(id: "HomeView")
                    dismissWindow(id: "BriefView")
                }
            }, label: {
                Image(systemName: "xmark.circle")
                    .frame(width: 30, height: 30)
            })
            Button(action: {
                openWindow(id: "ResponseView")
                dismissWindow(id: "CafeBriefView")
            }, label: {
                Image(systemName: "arrowshape.right.circle")
                    .frame(width: 30, height: 30)
            })
        }
        .onLoad {
            dismissWindow(id: "HomeView")
        }
        .font(.title)
        .tint(.indigo)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    BriefView(scenario: "Cafe")
}
