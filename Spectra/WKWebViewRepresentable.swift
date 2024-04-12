// MARK: - FILE INFORMATION
//
//  WKWebViewRepresentable.swift
//  Spectra
//
//  Created by @JTostitos on 2/3/24.
//
// MARK: - LICENSE
/*
 Copyright (c) 2024 Jonathan Tsistinas
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to use, copy, modify, merge, and publish the Software solely for non-commercial purposes. Distribution of the Software for profit, whether on Github or outside of Github, is expressly prohibited. Sub-licensing or selling copies of the Software is not allowed. Anyone who receives the software from the original source is allowed to do the aforementioned activities, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

// MARK: - CODE
import SwiftUI
import WebKit

struct WKWebViewRepresentable: UIViewRepresentable {
    let url: URL
    let wkWebViewControlsVM: WKWebViewControlsVM
    @Binding var isLoading: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let wkWebView = WKWebView(frame: .zero, configuration: wkWebViewConfiguration())
        
        let customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_3_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.2 Safari/605.1.15"
        wkWebView.setValue(customUserAgent, forKey: "customUserAgent")
        
        wkWebView.navigationDelegate = context.coordinator
        
        wkWebView.scrollView.backgroundColor = .clear
        wkWebView.isOpaque = false
        wkWebView.underPageBackgroundColor = .clear
        
        wkWebViewControlsVM.wkWebView = wkWebView
        
        wkWebView.load(URLRequest(url: url))
        return wkWebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WKWebViewRepresentable
        init(_ parent: WKWebViewRepresentable) {
            self.parent = parent
        }
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }
    }
    
    func wkWebViewConfiguration() -> WKWebViewConfiguration {
        let userContentController = WKUserContentController()
        
        let wkUserScriptArray: [WKUserScript] = [loadOnMobileBrowsers(), primeBackgroundStyling(), primeHeadersStyling(), fixVideoPlayer(), episodesElementStyling(), primeFootersStyling(), downloadEpisodeUnavailableActionBoxStyling(), episodeActionBoxStyling(), removeWatchPartyButtonStyling(), primeSkipLinkStyling()]
        
        for script in wkUserScriptArray {
            userContentController.addUserScript(script)
        }
        
//        userContentController.addUserScript(loadOnMobileBrowsers())
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        return configuration
    }
 
}

extension WKWebViewRepresentable {
    func loadOnMobileBrowsers() -> WKUserScript {
        guard let path = Bundle.main.path(forResource: "loadOnMobileBrowsers", ofType: "js") else {
            return WKUserScript()
        }
        
        guard let source = try? String(contentsOfFile: path) else { return WKUserScript() }
        
        let userScript = WKUserScript(source: source,
                                      injectionTime: .atDocumentEnd,
                                      forMainFrameOnly: false)
        
        return userScript
    }
    
    func fixVideoPlayer() -> WKUserScript {
        guard let path = Bundle.main.path(forResource: "fixVideoPlayer", ofType: "js") else {
            return WKUserScript()
        }
        
        guard let source = try? String(contentsOfFile: path) else { return WKUserScript() }
        
        let userScript = WKUserScript(source: source,
                                      injectionTime: .atDocumentStart,
                                      forMainFrameOnly: false)
        
        return userScript
    }
    
    func primeBackgroundStyling() -> WKUserScript {
        guard let path = Bundle.main.path(forResource: "primeBackgroundStyling", ofType: "js") else {
            return WKUserScript()
        }
        
        guard let source = try? String(contentsOfFile: path) else { return WKUserScript() }
        
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
    }
    
    func primeHeadersStyling() -> WKUserScript {
        guard let path = Bundle.main.path(forResource: "primeHeadersStyling", ofType: "js") else {
            return WKUserScript()
        }
        
        guard let source = try? String(contentsOfFile: path) else { return WKUserScript() }
        
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        
        return userScript
    }
    
    func primeFootersStyling() -> WKUserScript {
        guard let path = Bundle.main.path(forResource: "primeFootersStyling", ofType: "js") else {
            return WKUserScript()
        }
        
        guard let source = try? String(contentsOfFile: path) else { return WKUserScript() }
        
        let userScript = WKUserScript(source: source,
                                      injectionTime: .atDocumentEnd,
                                      forMainFrameOnly: false)
        
        return userScript
    }
    
    func episodesElementStyling() -> WKUserScript {
        guard let path = Bundle.main.path(forResource: "episodesElementStyling", ofType: "js") else {
            return WKUserScript()
        }
        
        guard let source = try? String(contentsOfFile: path) else { return WKUserScript() }
        
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        
        return userScript
    }
    
    func episodeActionBoxStyling() -> WKUserScript {
        guard let path = Bundle.main.path(forResource: "episodeActionBoxStyling", ofType: "js") else {
            return WKUserScript()
        }
        
        guard let source = try? String(contentsOfFile: path) else { return WKUserScript() }
        
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
    }
    
    func downloadEpisodeUnavailableActionBoxStyling() -> WKUserScript {
        guard let path = Bundle.main.path(forResource: "downloadEpisodeUnavailableActionBoxStyling", ofType: "js") else {
            return WKUserScript()
        }
        
        guard let source = try? String(contentsOfFile: path) else { return WKUserScript() }
        
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
    }
    
    func removeWatchPartyButtonStyling() -> WKUserScript {
        guard let path = Bundle.main.path(forResource: "removeWatchPartyButtonStyling", ofType: "js") else {
            return WKUserScript()
        }
        
        guard let source = try? String(contentsOfFile: path) else { return WKUserScript() }
        
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
    }
    
    func primeSkipLinkStyling() -> WKUserScript {
        guard let path = Bundle.main.path(forResource: "primeSkipLinkStyling", ofType: "js") else {
            return WKUserScript()
        }
        
        guard let source = try? String(contentsOfFile: path) else { return WKUserScript() }
        
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
    }
}
