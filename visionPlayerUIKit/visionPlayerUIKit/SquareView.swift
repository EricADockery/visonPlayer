//
//  SquareView.swift
//  MultiPlayer
//
//  Created by Eric Dockery on 6/7/23.
//

import SwiftUI

struct SquareView: View {
    
    let playableItem: PlayableItem
    let onSelection: () -> Void
    
    var body: some View {
        Button(action: {
            onSelection()
        }) {
            Text(playableItem.title)
                .padding()
        }
        .border(.yellow, width: 2.0)
        .tint(.blue)
    }
}

#Preview {
    SquareView(playableItem: PlayableItem(title: "First Movie", location: "url.com"), onSelection: {})
}
