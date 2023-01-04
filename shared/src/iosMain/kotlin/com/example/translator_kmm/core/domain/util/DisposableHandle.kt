package com.example.translator_kmm.core.domain.util

// wrapper to prevent exposing kotlinx.coroutines.DisposableHandle to iOS
fun interface DisposableHandle : kotlinx.coroutines.DisposableHandle