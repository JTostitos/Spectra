//
//  WKWebViewRepresentable.swift
//  Spectra
//
//  Created by Jonathan Tsistinas on 2/3/24.
//

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
    
    func wkUserScript() -> WKUserScript {
        guard let path = Bundle.main.path(forResource: "style", ofType: "css") else {
            return WKUserScript()
        }
        
        let css = try! String(contentsOfFile: path).components(separatedBy: .newlines).joined()
        let source = """
        var style = document.createElement('style'); style.innerHTML = '\(css)'; document.head.appendChild(style);
        Object.defineProperty(navigator, 'maxTouchPoints', { get:function() { return 1; } });
        """
        
        let userScript = WKUserScript(source: source,
                                      injectionTime: .atDocumentEnd,
                                      forMainFrameOnly: false)
        
        return userScript
    }
    
    func fixVideoPlayer() -> WKUserScript {
        let source = """
        Object.defineProperty(navigator, 'maxTouchPoints', { get:function() { return 1; } });
        """
        
        let userScript = WKUserScript(source: source,
                                      injectionTime: .atDocumentStart,
                                      forMainFrameOnly: false)
        
        return userScript
    }
    
    func wkWebViewConfiguration() -> WKWebViewConfiguration {
        let userContentController = WKUserContentController()
        userContentController.addUserScript(wkUserScript())
        userContentController.addUserScript(fixVideoPlayer())
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        return configuration
    }
 
}
