//
//  ViewModel.swift
//  IOSStudio
//
//  Created by Thomas on 10/5/2024.
//

import Foundation
import Observation

enum BaristaState {
    case idle
    case wave
    case angry
    case point
    case happy
    case disappointed
}

@Observable
class ViewModel {
    var baristaState = BaristaState.idle
    
}
