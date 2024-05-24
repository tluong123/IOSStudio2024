import SwiftUI
import RealityKit
import RealityKitContent



struct ImmersiveView: View {
    @Environment (ViewModel.self) var viewModel
    
    //    @State var cafeEntity: Entity = {
    //        let floorAnchor = AnchorEntity(.head)
    //        floorAnchor.position = [0, -1.8, 0 ]
    //      return floorAnchor
    //    }()
    
    var body: some View {
        RealityView {content in
            do{
                let scene = try await Entity(named: "Scene", in: realityKitContentBundle)
                //cafeEntity.addChild(scene)
                content.add(scene)
                
                let characterAnimationsSceneEntity = try await Entity(named: "Immersive", in: realityKitContentBundle)
                guard let waveModel = characterAnimationsSceneEntity.findEntity(named: "barista_waving") else { return }
                guard let angryModel = characterAnimationsSceneEntity.findEntity(named: "barista_angry") else { return }
                guard let happyModel = characterAnimationsSceneEntity.findEntity(named: "barista_thumbs_up") else { return }
                guard let pointModel = characterAnimationsSceneEntity.findEntity(named: "barista_point") else { return }
                guard let disappointedModel = characterAnimationsSceneEntity.findEntity(named: "barista_disappointed") else { return }
                
                viewModel.baristaIdle = scene.findEntity(named: "barista_idle")
                viewModel.idleAnimationResource = viewModel.baristaIdle?.availableAnimations.first
                viewModel.waveAnimationResource = waveModel.availableAnimations.first
                viewModel.angryAnimationResource = angryModel.availableAnimations.first
                viewModel.happyAnimationResource = happyModel.availableAnimations.first
                viewModel.pointAnimationResource = pointModel.availableAnimations.first
                viewModel.disappointedAnimationResource = disappointedModel.availableAnimations.first
                
                playAnimRepeated(baristaIdle: viewModel.baristaIdle, animationResource: viewModel.idleAnimationResource)
                
                
            }  catch {
                print("Error in RealityView: \(error)")
            }
            
        } .onAppear {
            AudioManager.shared.playBackgroundMusic()
            AudioManager.shared.setBackgroundMusicVolume(to: 0.5)  // Set to a default volume
        }
        .onDisappear {
            AudioManager.shared.stopBackgroundMusic()
        }
        
    }
}

func playAnimRepeated(baristaIdle: Entity?, animationResource: AnimationResource?) {
    if let baristaIdle = baristaIdle, let animationResource = animationResource {
        baristaIdle.playAnimation(animationResource.repeat())
    }
}
func playAnimSingle(baristaIdle: Entity?, animationResource: AnimationResource?) {
    if let baristaIdle = baristaIdle, let animationResource = animationResource {
        baristaIdle.playAnimation(animationResource)
    }
}


#Preview {
    ImmersiveView()
}
