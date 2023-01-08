//
//  IOSTranslateViewModel.swift
//  iosApp
//
//  Created by Kai Cilliers on 07/01/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

// using extension keyword seems to limit the visibility of this viewmodel to the TranslateScreen
// ensuring it only gets used by the TranslateScreen
extension TranslateScreen {
    // annotation ensures that the viewmodel class operations happen on the main thread, which is what we want
    @MainActor class IOSTranslateViewModel: ObservableObject {
        private var historyDataSource: HistoryDataSource
        private var translateUseCase: TranslateUseCase
        
        private var handle: DisposableHandle?
        
        // this class is wrapping this viewmodel defined in shared module
        private let viewModel: TranslateViewModel
        
        // observable type for UI, publish any changes to UI
        @Published var state: TranslateState = TranslateState(
            fromText: "",
            toText: nil,
            isTranslating: false,
            fromLanguage: UiLanguage(language: .english, imageName: "english"),
            toLanguage: UiLanguage(language: .japanese, imageName: "japanese"),
            isChoosingFromLanguage: false,
            isChoosingToLanguage: false,
            error: nil,
            history: []
        )
        
        init(historyDataSource: HistoryDataSource, translateUseCase: TranslateUseCase) {
            self.historyDataSource = historyDataSource
            self.translateUseCase = translateUseCase
            self.viewModel = TranslateViewModel(
                translateUseCase: translateUseCase,
                historyDataSource: historyDataSource,
                coroutineScope: nil
            )
        }
        
        func onEvent(event: TranslateEvent) {
            self.viewModel.onEvent(event: event)
        }
        
        // we call it as soon as UI is visible on screen (no concept of configuration changes, thus no risk of executing this twice)
        func startObserving() {
            handle = viewModel.state.subscribe(onCollect: { state in
                // essentially a null check
                if let state = state {
                    self.state = state
                }
            })
        }
        
        func dispose() {
            handle?.dispose()
        }
    }
}
