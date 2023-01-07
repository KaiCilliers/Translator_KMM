package com.example.translator_kmm.android.translate.presentation.modifiers

import androidx.compose.foundation.background
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material.MaterialTheme
import androidx.compose.ui.Modifier
import androidx.compose.ui.composed
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color

// using composed { } because this custom modifier relies on state i.e. system theme
//  always used when your modifier is stateful
fun Modifier.gradientSurface() = composed {
    if (isSystemInDarkTheme()) {
        Modifier
            .background(
                brush = Brush.verticalGradient(
                    colors = listOf(
                        // todo could potentially be placed in color resources file
                        //  I don't see the need now as I have no need for these colors anywhere else
                        Color(0xFF23262E),
                        Color(0xFF212329)
                    )
                )
            )
    } else {
        Modifier
            .background(MaterialTheme.colors.surface)
    }
}