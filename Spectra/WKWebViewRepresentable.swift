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
    
    func makeUIView(context: Context) -> WKWebView  {
        let wkWebView = webView(url: url)
        
        return wkWebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    
    func webView(url: URL) -> WKWebView {
        guard let path = Bundle.main.path(forResource: "style", ofType: "css") else {
            return WKWebView()
        }
        
        let css = try! String(contentsOfFile: path).components(separatedBy: .newlines).joined()
        let source = "var style = document.createElement('style'); style.innerHTML = '\(css)'; document.head.appendChild(style);"
        

        
        let userScript = WKUserScript(source: source,
                                      injectionTime: .atDocumentEnd,
                                      forMainFrameOnly: false)
        
        let userContentController = WKUserContentController()
        userContentController.addUserScript(userScript)
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
    
        let wkWebView = WKWebView(frame: .zero, configuration: configuration)
        wkWebView.scrollView.backgroundColor = .clear
        wkWebView.isOpaque = false
        wkWebView.underPageBackgroundColor = .clear

        wkWebView.load(URLRequest(url: url))
            
//        wkWebView.evaluateJavaScript(js, completionHandler: nil)
//        "body { background-color : transparent }"
        
        return wkWebView
    }
}
