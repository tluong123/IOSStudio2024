//
//  Feedback.swift
//  IOSStudio
//
//  Created by Lachlan Atack on 30/4/2024.
//

import Foundation

class Feedback: ObservableObject {
    @Published var feedback = "You passed."
    @Published var passed = false
}
