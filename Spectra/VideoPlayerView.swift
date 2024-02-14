//
//  VideoPlayerView.swift
//  Spectra
//
//  Created by Jonathan Tsistinas on 2/12/24.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(\.openWindow) var openWindow
    @Environment(\.openURL) var openURL
    @Environment(WKWebViewControlsVM.self) var wkWebViewControlsVM
    @State private var isLoading: Bool = false
    @Binding var url: String?
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            
            if let url =  URL(string: url!) {
                WKWebViewRepresentable(url: url, wkWebViewControlsVM: wkWebViewControlsVM, isLoading: $isLoading)
                    .opacity(isLoading ? 0 : 1)
                    .onAppear {
                        dismissWindow(id: "contentView")
                        let pathOnly = url.absoluteString.replacingOccurrences(of: "https://www.amazon.com/gp/video/detail", with: "")
                        openURL.callAsFunction(URL(string: pathOnly)!)
                    }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomOrnament) {
                Group {
                    //capture post request and simulate that here? or simulate key presses
                    Button {
                        openWindow(id: "contentView")
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    
                    Button {
                        wkWebViewControlsVM.reload()
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "gobackward.15")
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "playpause")
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "goforward.15")
                    }
                    
                    Spacer()
                    
                }
                .buttonBorderShape(.circle)
                .buttonStyle(.bordered)
            }
        }
    }
    
    func avPlayer() -> AVPlayer {
        return AVPlayer(url: URL(string: url!)!)
    }
}

#Preview {
    VideoPlayerView(url: Binding(projectedValue: .constant("https://www.amazon.com/gp/video/detail")))
}
