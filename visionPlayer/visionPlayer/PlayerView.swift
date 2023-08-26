//
//  PlayerView.swift
//  MultiPlayer
//
//  Created by Eric Dockery on 6/7/23.
//

import SwiftUI
import AVKit
import Combine

struct PlayerView: View {
    @State var player = AVPlayer()
    @State var playableItem: PlayableItem
    @Environment(\.dismissWindow) private var dismissWindow
    @State var cancellables = Set<AnyCancellable>()
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                updatePlayerView(item: playableItem)
            }
            .onDisappear {
                player.pause()
                player.replaceCurrentItem(with: nil)
            }
    }
}

extension PlayerView {
    func updatePlayerView(item: PlayableItem) {
        guard let url = URL(string: item.location)
        else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        setUpObservers()
    }
    
}

// MARK: Private methods
private extension PlayerView {

    func setUpObservers() {
        
        player.publisher(for: \.timeControlStatus)
            .sink {  timeStatus in
                switch timeStatus {
                case .paused:
                    self.playbackPaused()
                case .playing:
                    self.playbackDidResume()
                default:
                    return
                }
            }
            .store(in: &cancellables)
        
        player.publisher(for: \.status)
            .sink {  status in
                switch status {
                case .readyToPlay:
                    self.isReadyToPlay()
                case .failed:
                    self.playbackDidFail(with: player.error)
                case .unknown:
                    print("unknown Status for player current item")
                @unknown default:
                    print("unknown default status for player current item")
                }
            }
            .store(in: &cancellables)
        
        // MARK: - Current Item Publishers
        player.publisher(for: \.currentItem)
            .sink {  currentItem in
                self.currentItemDidChange()
            }
            .store(in: &cancellables)
        
        player.publisher(for: \.currentItem?.duration)
            .sink {  duration in
                self.currentItemDurationChanged(duration: duration)
            }
            .store(in: &cancellables)
        
        player.publisher(for: \.currentItem?.status)
            .sink {  status in
                switch status {
                case .readyToPlay:
                    print("Current item is ready for playback.")
                case .failed:
                    self.playbackDidFail(with: player.error)
                case .unknown:
                    print("unknown Status for player current item")
                case .none:
                    print("No currentItem found")
                @unknown default:
                    print("unknown default status for player current item")
                }
            }
            .store(in: &cancellables)
        
        
        // MARK: - Notifications
        NotificationCenter.default.publisher(for: Notification.Name.AVPlayerItemDidPlayToEndTime)
            .sink {  notification in
                guard (notification.object as? AVPlayerItem) == player.currentItem else { return}
                self.didPlayToEndTime()
            }
            .store(in: &cancellables)
        //MARK: - Audio Session
        NotificationCenter.default.publisher(for: AVAudioSession.interruptionNotification)
            .sink { _ in
                
            }
            .store(in: &cancellables)
    }
    
    func playbackPaused() {}
    
    func playbackDidResume() {}
    
    func isReadyToPlay() {
        player.play()
    }
    
    func playbackDidFail(with error: Error?) {
        withTransaction(\.dismissBehavior, .destructive) {
            dismissWindow.callAsFunction(id: "Player", value: playableItem)
        }
        
    }
    
    func currentItemDidChange() {}
    
    func currentItemDurationChanged(duration: CMTime?) {}
    
    func didPlayToEndTime() {}
    
    func sendHeartbeat(currentTime: Double) {}
}
