//
//  IOSStudioApp.swift
//  IOSStudio
//
//  Created by Thomas on 6/4/2024.
//

import SwiftUI

@main
struct IOSStudioApp: App {
    
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
            ResponseView()
        }
        .defaultSize(CGSize(width: 700, height: 400))
        
        WindowGroup (id: "FeedbackViewPass") {
            FeedbackView(result: "Pass")
        }
        .defaultSize(CGSize(width: 400, height: 400))
        
        WindowGroup (id: "FeedbackViewFail") {
            FeedbackView(result: "Fail")
        }
        .defaultSize(CGSize(width: 400, height: 400))
        
        
        ImmersiveSpace(id: "ImmersiveView")
        {
            ImmersiveView()
        }
    }
}
