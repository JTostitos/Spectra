// MARK: - FILE INFORMATION
//
//  VideoPlayerView.swift
//  Spectra
//
//  Created by @JTostitos on 2/12/24.
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
import AVKit
import JunoUI

struct VideoPlayerView: View {
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(\.openWindow) var openWindow
    @Environment(\.openURL) var openURL
    @Environment(WKWebViewControlsVM.self) var wkWebViewControlsVM
    @State var sliderValue: CGFloat = 0.5
    @State var isSliderActive = false
    @State private var isLoading: Bool = false
    @Binding var url: String?
    
    var body: some View {
        NavigationStack {
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
// I don't remember why I wanted to do this. Doesn't affect anything in the app.
//                            let pathOnly = url.absoluteString.replacingOccurrences(of: "https://www.amazon.com/gp/video/detail", with: "")
//                            openURL.callAsFunction(URL(string: pathOnly)!)
                            
                        }
                }
            }
            .ornament(attachmentAnchor: .scene(.bottom)) {
                VStack(spacing: 5) {
                    HStack {
                        Button {
                            openWindow(id: "contentView")
                        } label: {
                            Image(systemName: "house")
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "circle")
                        }
                        .disabled(true)
                        .opacity(0)
                        
                        Spacer()
                        
                        Text("Show Name, Title, and Episode")
                            .frame(minWidth: 300)
                        
                        Spacer()
                        
                        Button {
                            wkWebViewControlsVM.loadWebView(url: url!)
                        } label: {
                            Image(.backToVideo)
                        }
                        
                        Button {
                            wkWebViewControlsVM.reload()
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                        }
                    }
                    .buttonStyle(.bordered)
                    .padding(.horizontal, 35)
                    
                    HStack {
                        // Capture post request and simulate that here? or simulate key presses
                        Button {
                            
                        } label: {
                            Image(systemName: "gobackward.15")
                        }
                        
                        Button {
                            wkWebViewControlsVM.playPause()
                        } label: {
                            Image(systemName: "playpause")
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "goforward.15")
                        }
                        
                        JunoSlider(sliderValue: $sliderValue, maxSliderValue: 1.0, baseHeight: 10.0, expandedHeight: 22.0, label: "Video Progress") { editingChanged in
                            isSliderActive = editingChanged
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "speaker.wave.2.fill")
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.up.left.and.arrow.down.right")
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "xmark.circle")
                        }
                        
                    }
                    .padding(.horizontal, 35)
                }
                .frame(width: 800)
                .buttonBorderShape(.circle)
                .buttonStyle(.borderless)
                .padding(.vertical)
                .glassBackgroundEffect()
                .clipShape(.capsule(style: .continuous))
                .padding(.top, 75)
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
