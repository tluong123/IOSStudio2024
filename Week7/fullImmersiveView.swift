//
//  fullImmersiveView.swift
//  Week7
//
//  Created by Avinash Singh on 2/4/2024.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct fullImmersiveView: View {
    var body: some View {
        RealityView {content in
            
            guard let myEntity = create3DView() else {return}
            
            content.add(myEntity)
            
            if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle)
            {
                content.add(scene)
            }
            
        }
    }
    
    private func create3DView() ->Entity? {
        
        // Created a spahere with radiu 1000
        let sphere = MeshResource.generateSphere(radius: 1000)
        
        // Create material
        var material = UnlitMaterial()
        
        do {
            
            let texture = try TextureResource.load(named: "Kitchen2")
            
            material.color = .init(texture:.init(texture))
            
        
    } catch {}
        
        let myEntity = Entity()
        
        myEntity.components.set(ModelComponent(mesh: sphere, materials: [material]))
        
        myEntity.scale *= .init(x: -1, y: 1, z: 1)
        
        return myEntity
        
    }
}

#Preview {
    fullImmersiveView()
}
