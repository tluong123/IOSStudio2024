import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @Environment (ViewModel.self) var viewModel
    // Entity to set an Anchor
    @State public var waveAnimation: AnimationResource? = nil
    @State public var baristaIdle: Entity? = nil

    @State var cafeEntity: Entity = {
        let floorAnchor = AnchorEntity(world: .zero)
      return floorAnchor
    }()
    
    var body: some View {
        RealityView {content in
            do{
                let scene = try await Entity(named: "Scene", in: realityKitContentBundle)
                cafeEntity.addChild(scene)
                    content.add(cafeEntity)
                
                let characterAnimationsSceneEntity = try await Entity(named: "Immersive", in: realityKitContentBundle)
                guard let waveModel = characterAnimationsSceneEntity.findEntity(named: "barista_waving") else { return }
//                guard let angryModel = characterAnimationsSceneEntity.findEntity(named: "barista_angry") else { return }
//                guard let idleModel = characterAnimationsSceneEntity.findEntity(named: "barista_idle") else { return }
//               guard let happyModel = characterAnimationsSceneEntity.findEntity(named: "barista_thumbs_up") else { return }
//               guard let pointModel = characterAnimationsSceneEntity.findEntity(named: "barista_point") else { return }
//                guard let disappointModel = characterAnimationsSceneEntity.findEntity(named: "barista_disappoint") else { return }
                
                guard let baristaIdle = cafeEntity.findEntity(named: "barista_idle") else { return }
                
                
                guard let idleAnimationResource = waveModel.availableAnimations.first else { return }
                
                guard let waveAnimationResource = waveModel.availableAnimations.first else { return }
                let waveAnimation = try AnimationResource.sequence(with: [waveAnimationResource, idleAnimationResource.repeat()])
                playWaveSequence(baristaIdle: baristaIdle, idleAnimationResource: idleAnimationResource)

                
                Task {
                    self.baristaIdle = baristaIdle
                    self.waveAnimation = waveAnimation
                }
            }  catch {
                    print("Error in RealityView: \(error)")
            }


            
        }
    }
}
func playWaveSequence(baristaIdle: Entity?, idleAnimationResource: AnimationResource?) {
    if let baristaIdle = baristaIdle, let idleAnimationResource = idleAnimationResource {
        baristaIdle.playAnimation(idleAnimationResource.repeat())
    }
}
func playDisappointAnim ()
{
    
}
#Preview {
    ImmersiveView()
}
