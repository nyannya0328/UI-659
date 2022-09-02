//
//  CustomSceneView.swift
//  UI-659
//
//  Created by nyannyan0328 on 2022/09/02.
//

import SwiftUI
import SceneKit

struct CustomSceneView: UIViewRepresentable {
    
    @Binding var sceneName : SCNScene?
    func makeUIView(context: Context) -> SCNView  {
        
        let view = SCNView()
        view.allowsCameraControl = false
        view.autoenablesDefaultLighting = true
        view.scene = sceneName
        view.backgroundColor = .clear
        view.antialiasingMode = .multisampling2X

        return view
        
    }
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
}

