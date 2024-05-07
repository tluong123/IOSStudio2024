import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    // Entity to set an Anchor
    @State var myEntity: Entity = {
        let floorAnchor = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: SIMD2<Float>(0.6, 0.6)))
        floorAnchor.position = [0, 0, 0 ]
        return floorAnchor
    }()
    
    var body: some View {
        RealityView {content in
            if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle)
            {
                
                myEntity.addChild(scene)
                
                // Add main entity into scene
                content.add(myEntity)
            }
            
        }
        .gesture(TapGesture().targetedToAnyEntity().onEnded({ value in
            
            // Search all animation in target entity and play animation
            for anim in value.entity.availableAnimations {

            print("Tapped \(String(describing: anim.name))")

            value.entity.playAnimation(anim.repeat(duration: 2), transitionDuration: 1.25, startsPaused: false)

            }

            }))
    }
}

#Preview {
    ImmersiveView()
}
