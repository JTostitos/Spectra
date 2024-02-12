//
//  WKWebViewControlsVM.swift
//  Spectra
//
//  Created by Jonathan Tsistinas on 2/9/24.
//

import SwiftUI
import Observation
import WebKit

@Observable
class WKWebViewControlsVM {
    static let shared = WKWebViewControlsVM()
    
    var wkWebView: WKWebView?
 
    fileprivate func navigate(to primeVideoURL: String) -> URLRequest {
        return URLRequest(url: URL(string: primeVideoURL)!)
    }
    
    func loadWebView(url: String) {
        wkWebView?.load(navigate(to: url))
    }
    
    func reload() {
        wkWebView?.reload()
    }
    
    func goBack() {
        wkWebView?.goBack()
    }
    
    func goForward() {
        wkWebView?.goForward()
    }
    
    func webpageTitle() -> String {
        return wkWebView?.title ?? "Hulu"
    }
}
