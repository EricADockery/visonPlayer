//
//  PlayableItem.swift
//  MultiPlayer
//
//  Created by Eric Dockery on 6/7/23.
//

import Foundation

struct PlayableItem: Identifiable, Codable, Hashable {
    var id: String {
        title + location
    }

    var title: String
    var location: String
}
