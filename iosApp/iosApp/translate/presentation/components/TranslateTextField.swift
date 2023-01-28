//
//  TranslateTextField.swift
//  iosApp
//
//  Created by Kai Cilliers on 08/01/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared
import UniformTypeIdentifiers
struct TranslateTextField: View {
    // iOS two-way binding
    @Binding var fromText: String
    let toText: String?
    let isTranslating: Bool
    let fromLanguageModel: UiLanguage
    let toLanguageModel: UiLanguage
    let onTranslateEvent: (TranslateEvent) -> Void
    
    var body: some View {
        if toText == nil  || isTranslating {
            IdleTextField(
                fromText: $fromText,
                isTranslating: isTranslating,
                onTranslateEvent: onTranslateEvent
            )
            .gradientSurface()
            .cornerRadius(15)
            .animation(.easeInOut, value: isTranslating)
            .shadow(radius: 4)
        } else {
            TranslatedTextField(
                fromText: fromText,
                toText: toText ?? "",
                fromLanguage: fromLanguageModel,
                toLanguage: toLanguageModel,
                onTranslateEvent: onTranslateEvent
            )
            .padding()
            .gradientSurface()
            .cornerRadius(15)
            .animation(.easeInOut, value: isTranslating)
            .shadow(radius: 4)
            .onTapGesture {
                onTranslateEvent(TranslateEvent.EditTranslation())
            }
        }
    }
}

struct TranslateTextField_Previews: PreviewProvider {
    static var previews: some View {
        TranslateTextField(
            fromText: Binding(
                get: { "test" },
                set: { value in }
            ),
            toText: "nil",
            isTranslating: false,
            fromLanguageModel: UiLanguage(language: .english, imageName: "english"),
            toLanguageModel: UiLanguage(language: .japanese, imageName: "japanese"),
            onTranslateEvent: { event in }
        )
    }
}

private extension TranslateTextField {
    
    struct IdleTextField: View {
        @Binding var fromText: String
        let isTranslating: Bool
        let onTranslateEvent: (TranslateEvent) -> Void
        
        var body: some View {
            TextEditor(text: $fromText)
                .frame(
                    maxWidth: .infinity,
                    minHeight: 200,
                    alignment: .topLeading
                )
                .padding()
                .foregroundColor(Color.onSurface)
                .overlay(alignment: .bottomTrailing) {
                    ProgressButton(
                        text: "Translate",
                        isLoading: isTranslating,
                        onClick: {
                            onTranslateEvent(TranslateEvent.Translate())
                        }
                    )
                    .padding(.trailing)
                    .padding(.bottom)
                }
                .onAppear {
                    // iOS has a system default background which we are setting to transparent
                    UITextView.appearance().backgroundColor = .clear
                }
        }
    }
    
    struct TranslatedTextField: View {
            let fromText: String
            let toText: String
            let fromLanguage: UiLanguage
            let toLanguage: UiLanguage
            let onTranslateEvent: (TranslateEvent) -> Void
        
            private let tts = TextToSpeech()
            
            var body: some View {
                VStack(alignment: .leading) {
                    LanguageDisplay(languageModel:fromLanguage)
                    Text(fromText)
                        .foregroundColor(.onSurface)
                    HStack {
                        Spacer()
                        Button(action: {
                            UIPasteboard.general.setValue(
                                fromText,
                                forPasteboardType: UTType.plainText.identifier
                            )
                        }) {
                            Image(uiImage: UIImage(named: "copy")!)
                                .renderingMode(.template)
                                .foregroundColor(.lightBlue)
                        }
                        Button(action: {
                            onTranslateEvent(TranslateEvent.CloseTranslation())
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.lightBlue)
                        }
                    }
                    Divider()
                        .padding()
                    LanguageDisplay(languageModel: toLanguage)
                        .padding(.bottom)
                    Text(toText)
                        .foregroundColor(.onSurface)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            UIPasteboard.general.setValue(
                                toText,
                                forPasteboardType: UTType.plainText.identifier
                            )
                        }) {
                            Image(uiImage: UIImage(named: "copy")!)
                                .renderingMode(.template)
                                .foregroundColor(.lightBlue)
                        }
                        Button(action: {
                            tts.speak(
                                text: toText,
                                language: toLanguage.language.langCode
                            )
                        }) {
                            Image(systemName: "speaker.wave.2")
                                .foregroundColor(.lightBlue)
                        }
                    }
                }
            }
        }
}
