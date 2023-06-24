//
//  PlayerView.swift
//  MultiPlayer
//
//  Created by Eric Dockery on 6/7/23.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    @State var player = AVPlayer()
    @State var playableItem: PlayableItem
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                updatePlayerView(item: playableItem)
            }
            .onReceive(player.publisher(for: \.status),
                       perform: { status in
                switch status {
                case .readyToPlay:
                    player.play()
                case .failed:
                    dismissWindow(id: "Player", value: playableItem)
                case .unknown:
                    return
                @unknown default:
                    return
                }
                
            })
            
    }
}

extension PlayerView {
    func updatePlayerView(item: PlayableItem) {
        guard let url = URL(string: item.location)
            else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
    }
}


#Preview {
    PlayerView(playableItem: PlayableItem(title: "adsf", location: "asdf"))
}
