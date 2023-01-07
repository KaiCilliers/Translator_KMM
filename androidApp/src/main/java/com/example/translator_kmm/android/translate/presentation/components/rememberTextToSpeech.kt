package com.example.translator_kmm.android.translate.presentation.components

import android.speech.tts.TextToSpeech
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.ui.platform.LocalContext

@Composable
fun rememberTextToSpeech(): TextToSpeech {
    val context = LocalContext.current
    val tts = TextToSpeech(context, null)

    DisposableEffect(key1 = tts) {
        onDispose {
            tts.apply { stop(); shutdown() }
        }
    }
    return tts
}