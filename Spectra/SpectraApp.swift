// MARK: - FILE INFORMATION
//
//  SpectraApp.swift
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

@main
struct SpectraApp: App {
    @State private var wkWebViewControlsVM = WKWebViewControlsVM.shared
    
    var body: some Scene {
        WindowGroup(id: "contentView") {
            ContentView()
                .frame(width: 1600, height: 1000)
                .environment(wkWebViewControlsVM)
        }
        .windowResizability(.contentSize)
        
        WindowGroup(id: "videoPlayerView", for: String.self) { url in
            VideoPlayerView(url: url)
                .frame(width: 1600, height: 1000)
                .environment(wkWebViewControlsVM)
        }
        .windowResizability(.contentSize)
    }
}
