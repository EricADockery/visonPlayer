//
//  visionPlayerUIKitApp.swift
//  visionPlayerUIKit
//
//  Created by Eric Dockery on 8/26/23.
//

import SwiftUI

@main
struct visionPlayerUIKitApp: App {
    @State var immersionStyle: ImmersionStyle = .full
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.plain)

        WindowGroup(id: "Player", for: PlayableItem.self) { $playerItem in
            PlayerView(playableItem: playerItem!)
        }
        .windowStyle(.plain)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
        .immersionStyle(selection: $immersionStyle, in: .full)
    }
}
