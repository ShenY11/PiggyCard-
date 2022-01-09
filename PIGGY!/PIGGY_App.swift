//
//  PIGGY_App.swift
//  PIGGY!
//
//  Created by 沈钰婷 on 2021/12/22.
//

import SwiftUI

@main
struct PIGGY_App: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiCardModel()
            PiggyEmojiGameView(viewModel: game)
        }
    }
}
