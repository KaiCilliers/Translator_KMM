package com.example.translator_kmm.android.translate.presentation

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.translator_kmm.core.domain.util.CommonStateFlow
import com.example.translator_kmm.translate.domain.history.HistoryDataSource
import com.example.translator_kmm.translate.domain.translate.TranslateUseCase
import com.example.translator_kmm.translate.presentation.TranslateEvent
import com.example.translator_kmm.translate.presentation.TranslateState
import com.example.translator_kmm.translate.presentation.TranslateViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

// todo add working savedstatehandle implementation
@HiltViewModel
class AndroidTranslateViewModel @Inject constructor(
    private val translateUseCase: TranslateUseCase,
    private val historyDataSource: HistoryDataSource,
) : ViewModel() {

    private val sharedViewModel by lazy {
        TranslateViewModel(
            translateUseCase = translateUseCase,
            historyDataSource = historyDataSource,
            coroutineScope = viewModelScope
        )
    }

    val state: CommonStateFlow<TranslateState> = sharedViewModel.state

    fun onEvent(event: TranslateEvent) {
        sharedViewModel.onEvent(event)
    }

}