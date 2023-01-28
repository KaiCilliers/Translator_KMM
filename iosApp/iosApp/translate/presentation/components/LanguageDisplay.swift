//
//  LanguageDisplay.swift
//  iosApp
//
//  Created by Kai Cilliers on 08/01/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct LanguageDisplay: View {
    var languageModel: UiLanguage
    
    var body: some View {
        HStack {
            SmallLanguageIcon(languageModel: languageModel)
                .padding(.trailing, 5)
            Text(languageModel.language.langName)
                .foregroundColor(.lightBlue)
        }
    }
}

struct LanguageDisplay_Previews: PreviewProvider {
    static var previews: some View {
        LanguageDisplay(
            languageModel: UiLanguage(
                language: .english,
                imageName: "english"
            )
        )
    }
}
