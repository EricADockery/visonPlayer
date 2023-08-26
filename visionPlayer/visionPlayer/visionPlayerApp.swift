//
//  visionPlayerApp.swift
//  visionPlayer
//
//  Created by Eric Dockery on 8/25/23.
//

import SwiftUI

@main
struct visionPlayerApp: App {
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
        .immersionStyle(selection: $immersionStyle, in: .mixed)
    }
}
