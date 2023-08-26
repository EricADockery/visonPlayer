//
//  PlayerView.swift
//  MultiPlayer
//
//  Created by Eric Dockery on 6/7/23.
//

import SwiftUI
import UIKit
import AVKit
import Combine

struct PlayerView: UIViewControllerRepresentable {
    var playableItem: PlayableItem
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = PlayerViewController()
        controller.playableItem = playableItem
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}



final class PlayerViewController: UIViewController {
    var playerViewController: AVPlayerViewController? = AVPlayerViewController()
    var player = AVPlayer()
    var playableItem: PlayableItem?
    @Environment(\.dismissWindow) private var dismissWindow
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let playableItem = playableItem else { return }
        setUpPlayerViewController()
        updatePlayerView(item: playableItem)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.pause()
        playerViewController = nil
    }

}

extension PlayerViewController {
    func updatePlayerView(item: PlayableItem) {
        guard let url = URL(string: item.location)
        else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        setUpObservers()
        setUpPlayerComponents()
    }
    
}

// MARK: Private methods
private extension PlayerViewController {
    func setUpPlayerViewController() {
        guard let playerView = playerViewController?.view else { return }
        view.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerViewController?.player = player
    }
    
    func setUpObservers() {
        
        player.publisher(for: \.timeControlStatus)
            .sink { [weak self]  timeStatus in
                switch timeStatus {
                case .paused:
                    self?.playbackPaused()
                case .playing:
                    self?.playbackDidResume()
                default:
                    return
                }
            }
            .store(in: &cancellables)
        
        player.publisher(for: \.status)
            .sink { [weak self] status in
                guard let self = self else { return }
                switch status {
                case .readyToPlay:
                    self.isReadyToPlay()
                case .failed:
                    self.playbackDidFail(with: self.player.error)
                case .unknown:
                    print("unknown Status for player current item")
                @unknown default:
                    print("unknown default status for player current item")
                }
            }
            .store(in: &cancellables)
        
        // MARK: - Current Item Publishers
        player.publisher(for: \.currentItem)
            .sink { [weak self] currentItem in
                self?.currentItemDidChange()
            }
            .store(in: &cancellables)
        
        player.publisher(for: \.currentItem?.duration)
            .sink { [weak self]  duration in
                self?.currentItemDurationChanged(duration: duration)
            }
            .store(in: &cancellables)
        
        player.publisher(for: \.currentItem?.status)
            .sink { [weak self] status in
                guard let self = self else { return }
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
            .sink {[weak self] notification in
                guard (notification.object as? AVPlayerItem) == self?.player.currentItem else { return}
                self?.didPlayToEndTime()
            }
            .store(in: &cancellables)
        //MARK: - Audio Session
        NotificationCenter.default.publisher(for: AVAudioSession.interruptionNotification)
            .sink {[weak self] _ in
                
            }
            .store(in: &cancellables)
    }
    
    func setUpPlayerComponents() {
        let contentView = ContentView()
        let viewCtrl = UIHostingController(rootView: contentView)
        viewCtrl.title = "Other Things to watch"
        playerViewController?.customInfoViewControllers = [
            viewCtrl
        ]
        
        playerViewController?.contextualActions = [UIAction(image: UIImage(systemName: "circle"), handler: { _ in
            print("Eric Do Stuff Here")
        })]
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
