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
    
    @State var currentlyPlayingItems: [PlayableItem] = []
    // Although this works, its not ideall for users
   // @Environment(\.openWindow) private var openWindow
   // @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        NavigationStack {
            VStack {
               ImmersionModesView()
                HStack {
                    ForEach(model.buttons) { button in
                        /*SquareView(playableItem: button,
                                   onSelection: {
                            onSelection(item: button)
                        })*/
                        SquareView(playableItem: button)
                           
                    }
                }
                .frame(minHeight: 100)
            }
        }
        
    }
}

struct ImmersionModesView: View {
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    var body: some View {
        HStack {
            Button("Click to open Immersion!") {
                Task {
                    await openImmersiveSpace(id: "ImmersiveSpace")
                }
            }
            Button("Click to close Immersion!") {
                Task {
                    await dismissImmersiveSpace()
                }
            }
        }
    }
}

extension ContentView {
    
    /*func onSelection(item: PlayableItem) {
        if currentlyPlayingItems.contains(item) {
            dismissWindow(id: "Player", value: item)
        } else {
            currentlyPlayingItems.append(item)
            openWindow(id: "Player", value: item)
        }
    }*/
}


#Preview {
        ContentView()
}
