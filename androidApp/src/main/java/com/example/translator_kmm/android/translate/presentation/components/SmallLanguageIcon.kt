package com.example.translator_kmm.android.translate.presentation.components

import androidx.compose.foundation.layout.size
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import coil.compose.AsyncImage
import com.example.translator_kmm.core.presentation.UiLanguage

@Composable
fun SmallLanguageIcon(
    languageModel: UiLanguage,
    modifier: Modifier = Modifier,
) {
    AsyncImage(
        model = languageModel.drawableRes,
        contentDescription = languageModel.language.langName,
        modifier = modifier.size(25.dp)
    )
}