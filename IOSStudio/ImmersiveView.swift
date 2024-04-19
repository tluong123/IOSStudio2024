import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        RealityView {content in
            if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle)
            {
                content.add(scene)
                // Add an ImageBasedLight for the immersive content
                guard let resource = try? await EnvironmentResource(named: "shiwai_a") else { return }
                //An ImageBasedLightReceiverComponent has been set up for this entity, which enables the entity to receive image-based lighting.
                let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
                scene.components.set(iblComponent)
                scene.components.set(ImageBasedLightReceiverComponent(imageBasedLight: scene))
            }
            
        }
    }
}

#Preview {
    ImmersiveView()
}
