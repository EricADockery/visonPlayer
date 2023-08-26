//
//  ContentViewModel.swift
//  MultiPlayer
//
//  Created by Eric Dockery on 6/7/23.
//

import Foundation

final class ContentViewModel {
    @Published var selectedButton: PlayableItem?
    private(set) var buttons: [PlayableItem]
    
    init(buttons: [PlayableItem]) {
        self.buttons = buttons
    }
}
