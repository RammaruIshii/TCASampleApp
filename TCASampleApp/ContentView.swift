//
//  ContentView.swift
//  TCASampleApp
//
//  Created by 石井蘭丸 on 2024/12/12.
//

import SwiftUI
import ComposableArchitecture

// Store: State, Action, Reducer, Enviromentの4項目を結びつけるオブジェクト
struct AppStore {
    
    // State: アプリケーションの状態
    // 通常、特定の画面や機能に関する状態を保持
    // 現在の状態を反映し、UIの表示やアクションのトリガーに使用される
    struct AppState: Equatable {
        var count = 0
    }
    
    // Action: 状態を変更するためのアクションを表す
    // ユーザーの操作や外部からのイベントに応じて発生
    // 発生したイベントはReducer内で処理される、状態の変更のトリガーを表現
    enum AppAction: Equatable {
        case increment
        case decrement
    }
    
    // Environment: 外部依存関係（APIクライアントや動作スレッドなど）を提供する
    struct AppEnvironment {}
    
    // Reducer: アクションに応じて状態を変更する
    // 状態とアクションを受け取り、新しい状態を返す
    let reducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, _ in
        // アクションによって状態の更新
        switch action {
        case .increment:
            state.count += 1
            return .none
        case .decrement:
            state.count -= 1
            return .none
        }
    }
}

struct ContentView: View {
    let store: Store<AppStore.AppState, AppStore.AppAction>
    
    var body: some View {
        // WithViewStore: SwiftUIのViewとStoreを結びつけるためのオブジェクト
        // ViewがStoreの状態を監視し、アクションを発火
        WithViewStore(self.store) { viewStore in
            VStack {
                // 状態をViewに表示
                Text("カウント: \(viewStore.count)")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    Button {
                        // アクションを発火
                        viewStore.send(.decrement)
                    } label: {
                        Text("-")
                            .font(.largeTitle)
                            .padding()
                    }
                    
                    Button {
                        viewStore.send(.increment)
                    } label: {
                        Text("+")
                            .font(.largeTitle)
                            .padding()
                    }
                }
            }
            .padding()
        }
    }
}
