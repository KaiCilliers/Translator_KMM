//
//  LanguageDropDownItem.swift
//  iosApp
//
//  Created by Kai Cilliers on 07/01/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct LanguageDropDownItem: View {
    var languageModel: UiLanguage
    var onClick: () -> Void
    
    var body: some View {
        Button(action: onClick) {
            HStack {
                if let image = UIImage(named: languageModel.imageName.lowercased()) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.trailing, 5)
                    Text(languageModel.language.langName)
                        .foregroundColor(.textBlack)
                }
            }
        }
    }
}

struct LanguageDropDownItem_Previews: PreviewProvider {
    static var previews: some View {
        LanguageDropDownItem(
            languageModel: UiLanguage(language: .japanese, imageName: "japanese"),
            onClick: {}
        )
    }
}
