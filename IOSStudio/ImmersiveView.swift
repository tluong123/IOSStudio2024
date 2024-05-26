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
                guard let myEntity = create3DView() else {return}
                content.add(myEntity)
                
                let characterAnimationsSceneEntity = try await Entity(named: "Immersive", in: realityKitContentBundle)
                guard let waveModel = characterAnimationsSceneEntity.findEntity(named: "barista_waving") else { return }
                guard let angryModel = characterAnimationsSceneEntity.findEntity(named: "barista_angry") else { return }
                guard let happyModel = characterAnimationsSceneEntity.findEntity(named: "barista_thumbs_up") else { return }
                guard let pointModel = characterAnimationsSceneEntity.findEntity(named: "barista_point") else { return }
                guard let disappointedModel = characterAnimationsSceneEntity.findEntity(named: "barista_disappointed") else { return }
                
                guard let npc = scene.findEntity(named: "npc") else { return }
                guard let npc1 = scene.findEntity(named: "npc1") else { return }
                guard let npc2 = scene.findEntity(named: "npc2") else { return }
                guard let npc3 = scene.findEntity(named: "npc4") else { return }
                guard let npc4 = scene.findEntity(named: "npc5") else { return }
                
                viewModel.baristaIdle = scene.findEntity(named: "barista_idle")
                viewModel.idleAnimationResource = viewModel.baristaIdle?.availableAnimations.first
                viewModel.waveAnimationResource = waveModel.availableAnimations.first
                viewModel.angryAnimationResource = angryModel.availableAnimations.first
                viewModel.happyAnimationResource = happyModel.availableAnimations.first
                viewModel.pointAnimationResource = pointModel.availableAnimations.first
                viewModel.disappointedAnimationResource = disappointedModel.availableAnimations.first
                
                viewModel.npcAnimationResource = npc.availableAnimations.first
                viewModel.npc1AnimationResource = npc1.availableAnimations.first
                viewModel.npc2AnimationResource = npc2.availableAnimations.first
                viewModel.npc3AnimationResource = npc3.availableAnimations.first
                viewModel.npc4AnimationResource = npc4.availableAnimations.first
                
                playAnimRepeated(baristaIdle: npc, animationResource: viewModel.npcAnimationResource)
                playAnimRepeated(baristaIdle: npc1, animationResource: viewModel.npc1AnimationResource)
                playAnimRepeated(baristaIdle: npc2, animationResource: viewModel.npc2AnimationResource)
                playAnimRepeated(baristaIdle: npc3, animationResource: viewModel.npc3AnimationResource)
                playAnimRepeated(baristaIdle: npc4, animationResource: viewModel.npc4AnimationResource)
                
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
private func create3DView() ->Entity? {
    
    // Created a spahere with radiu 1000
    let sphere = MeshResource.generateSphere(radius: 1000)
    
    // Create material
    var material = UnlitMaterial()
    
    do {
        
        let texture = try TextureResource.load(named: "panoramic-sea")
        
        material.color = .init(texture:.init(texture))
        
    
} catch {}
    
    let myEntity = Entity()
    
    myEntity.components.set(ModelComponent(mesh: sphere, materials: [material]))
    
    myEntity.scale *= .init(x: -1, y: 1, z: 1)
    
    return myEntity
    
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
