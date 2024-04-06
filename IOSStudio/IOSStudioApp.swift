//
//  IOSStudioApp.swift
//  IOSStudio
//
//  Created by Thomas on 6/4/2024.
//

import SwiftUI

@main
struct IOSStudioApp: App {
    @State var immersionMode: ImmersionStyle = .progressive
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        
    }
}
