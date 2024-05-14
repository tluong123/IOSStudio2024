//
//  ViewModel.swift
//  IOSStudio
//
//  Created by Thomas on 10/5/2024.
//

import Foundation
import Observation
import SwiftUI
import RealityKit
import RealityKitContent


@Observable
class ViewModel {
    var baristaIdle: Entity? = nil
    var animationResource: AnimationResource? = nil
    var angryAnimationResource: AnimationResource? = nil
    var idleAnimationResource: AnimationResource? = nil
    var pointAnimationResource: AnimationResource? = nil
    var waveAnimationResource: AnimationResource? = nil
    var disappointedAnimationResource: AnimationResource? = nil
    var happyAnimationResource: AnimationResource? = nil
}

//          playAnimRepeated(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.disappointedAnimationResource) THIS IS FOR REPEATED ANIMATIONS
//          playAnimSingle(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.waveAnimationResource)           THIS IS FOR ANIMATIONS TO BE PLAYED ONCE
//          Interchange this part: viewModel.waveAnimationResource to any of the variables above.
//
