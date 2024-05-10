//
//  IOSStudioApp.swift
//  IOSStudio
//
//  Created by Thomas on 6/4/2024.
//

import SwiftUI

@main
struct IOSStudioApp: App {
    @State private var viewModel = ViewModel()
    var feedback = Feedback()
    
    var body: some Scene {
        WindowGroup (id: "HomeView"){
            HomeView()
        }
        .defaultSize(CGSize(width: 400, height: 400))
        
        WindowGroup(id: "CafeBriefView") {
            BriefView(scenario: "Cafe")
        }
        .defaultSize(CGSize(width: 400, height: 400))
        
        WindowGroup (id: "ResponseView") {
            ResponseView().environmentObject(feedback)
                .environment(viewModel)
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
