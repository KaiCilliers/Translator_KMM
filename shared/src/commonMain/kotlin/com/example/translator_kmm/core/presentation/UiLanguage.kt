package com.example.translator_kmm.core.presentation

import com.example.translator_kmm.core.domain.language.Language

// each platform has a different way to reference image vectors
expect class UiLanguage {
    val language: Language
    companion object {
        fun byCode(langCode: String): UiLanguage
        val allLanguages: List<UiLanguage>
    }
}