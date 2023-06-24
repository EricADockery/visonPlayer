//
//  visionPlayerApp.swift
//  visionPlayer
//
//  Created by Eric Dockery on 6/24/23.
//

import SwiftUI

@main
struct visionPlayerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.plain)

        WindowGroup(id: "Player", for: PlayableItem.self) { $playerItem in
            PlayerView(playableItem: playerItem!)
        }
        .windowStyle(.plain)
    }
}
