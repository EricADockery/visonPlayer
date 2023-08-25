//
//  MultiPlayerApp.swift
//  MultiPlayer
//
//  Created by Eric Dockery on 6/7/23.
//

import SwiftUI
enum MultiPlayerApp {
    static let buttons = [
        PlayableItem(title: "Tears of Steel", location: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8"),
        PlayableItem(title: "fMP4", location: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8"),
        PlayableItem(title: "Live Akamai", location: "https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8"),
        PlayableItem(title: "Bunnies", location: "https://live-par-1-abr-cdn.livepush.io/live_abr_cdn/emaIqCGoZw-6/index.m3u8"),
        PlayableItem(title: "Bunnies VOD", location: "https://live-par-2-abr.livepush.io/vod/bigbuckbunny/index.m3u8")
        
    ]
}
