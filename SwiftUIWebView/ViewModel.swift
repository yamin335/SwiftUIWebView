//
//  File.swift
//  SwiftUIWebView
//
//  Created by Md. Yamin on 4/25/20.
//  Copyright © 2020 Md. Yamin. All rights reserved.
//

import Foundation
import Combine
class ViewModel: ObservableObject {
    var webViewNavigationPublisher = PassthroughSubject<WebViewNavigation, Never>()
    var showWebTitle = PassthroughSubject<String, Never>()
    var showLoader = PassthroughSubject<Bool, Never>()
    var valuePublisher = PassthroughSubject<String, Never>()
}

// For identifiying WebView's forward and backward navigation
enum WebViewNavigation {
    case backward, forward, reload
}

// For identifying what type of url should load into WebView
enum WebUrlType {
    case localUrl, publicUrl
}
