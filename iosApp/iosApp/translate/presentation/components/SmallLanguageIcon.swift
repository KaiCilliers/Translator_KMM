//
//  SmallLanguageIcon.swift
//  iosApp
//
//  Created by Kai Cilliers on 07/01/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct SmallLanguageIcon: View {
    var languageModel: UiLanguage
    
    var body: some View {
        Image(uiImage: UIImage(named: languageModel.imageName.lowercased())!)
            .resizable()
            .frame(width: 30, height: 30)
    }
}

struct SmallLanguageIcon_Previews: PreviewProvider {
    static var previews: some View {
        SmallLanguageIcon(languageModel: UiLanguage(language: .japanese, imageName: "japanese"))
    }
}
