//
//  TCASampleAppApp.swift
//  TCASampleApp
//
//  Created by 石井蘭丸 on 2024/12/12.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCASampleAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(
                initialState: AppStore.AppState(),
                reducer: AppStore().reducer,
                environment: AppStore.AppEnvironment()
            ))
        }
    }
}
