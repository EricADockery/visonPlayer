//
//  ContentView.swift
//  MultiPlayer
//
//  Created by Eric Dockery on 6/7/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var model = ContentViewModel(buttons: MultiPlayerApp.buttons)
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        VStack {
            HStack {
                ForEach(model.buttons) { button in
                    SquareView(playableItem: button,
                               onSelection: {
                        onSelection(item: button)
                    })
                }
            }
            .frame(minHeight: 100)
        }
    }
}

extension ContentView2 {
    
    func onSelection(item: PlayableItem) {
        openWindow(id: "Player", value: item)
    }
}


#Preview {
        ContentView2()
}
