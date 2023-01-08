//
//  LanguageDropDown.swift
//  iosApp
//
//  Created by Kai Cilliers on 07/01/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct LanguageDropDown: View {
    var languageModel: UiLanguage
    var isOpen: Bool
    var selectLanguage: (UiLanguage) -> Void
    
    var body: some View {
        Menu {
            VStack {
                ForEach(UiLanguage.Companion().allLanguages, id: \.self.language.langCode) { languageItem in
                    LanguageDropDownItem(
                        languageModel: languageItem,
                        onClick: { selectLanguage(languageItem) }
                    )
                }
            }
        } label: {
            HStack {
                SmallLanguageIcon(languageModel: languageModel)
                Text(languageModel.language.langName)
                    .foregroundColor(.lightBlue)
                Image(systemName: isOpen ? "chevron.up" : "chevron.down")
                    .foregroundColor(.lightBlue)
            }
        }
    }
}

struct LanguageDropDown_Previews: PreviewProvider {
    static var previews: some View {
        LanguageDropDown(
            languageModel: UiLanguage(language: .japanese, imageName: "japanese"),
            isOpen: true,
            selectLanguage: {language in }
        )
    }
}
