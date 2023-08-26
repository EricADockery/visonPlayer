//
//  ImmersiveView.swift
//  visionPlayer
//
//  Created by Eric Dockery on 6/25/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let entity = try? await Entity(named: "Rome", in: realityKitContentBundle) {
                content.add(entity)
            }
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
