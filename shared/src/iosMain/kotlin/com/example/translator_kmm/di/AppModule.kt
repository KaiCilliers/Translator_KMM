package com.example.translator_kmm.di

import com.example.translator_kmm.database.TranslateDatabase
import com.example.translator_kmm.translate.data.history.SqlDelightHistoryDataSource
import com.example.translator_kmm.translate.data.local.DatabaseDriverFactory
import com.example.translator_kmm.translate.data.remote.HttpClientFactory
import com.example.translator_kmm.translate.data.translate.KtorTranslateClient
import com.example.translator_kmm.translate.domain.history.HistoryDataSource
import com.example.translator_kmm.translate.domain.translate.TranslateClient
import com.example.translator_kmm.translate.domain.translate.TranslateUseCase

// DI injection for iOS using lazy initialisation
class AppModule {

    val historyDataSource: HistoryDataSource by lazy {
        SqlDelightHistoryDataSource(
            TranslateDatabase(
                DatabaseDriverFactory().create()
            )
        )
    }

    private val translateClient: TranslateClient by lazy {
        KtorTranslateClient(
            HttpClientFactory().create()
        )
    }

    val translateUseCase: TranslateUseCase by lazy {
        TranslateUseCase(translateClient, historyDataSource)
    }

}