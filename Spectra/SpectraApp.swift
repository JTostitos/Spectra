//
//  SpectraApp.swift
//  Spectra
//
//  Created by Jonathan Tsistinas on 2/3/24.
//

import SwiftUI

@main
struct SpectraApp: App {
    @State private var wkWebViewControlsVM = WKWebViewControlsVM.shared
    
    var body: some Scene {
        WindowGroup(id: "contentView") {
            ContentView()
                .frame(width: 1400, height: 1000)
                .environment(wkWebViewControlsVM)
        }
        .windowResizability(.contentSize)
        
        WindowGroup(id: "videoPlayerView", for: String.self) { url in
            VideoPlayerView(url: url)
                .frame(width: 1400, height: 1000)
                .environment(wkWebViewControlsVM)
        }
        .windowResizability(.contentSize)
    }
}
