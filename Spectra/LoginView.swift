// MARK: - FILE INFORMATION
//
//  LoginView.swift
//  Spectra
//
//  Created by @JTostitos on 2/13/24.
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

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(WKWebViewControlsVM.self) var wkWebViewControlsVM
    @Binding var isLoading: Bool
    @Binding var primeVideoPlaces: PrimeVideoPlaces
    
    var body: some View {
        NavigationStack {
            ZStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                
                if let url =  URL(string: primeVideoPlaces.loginURL) {
                    WKWebViewRepresentable(url: url, wkWebViewControlsVM: wkWebViewControlsVM, isLoading: $isLoading)
                        .opacity(isLoading ? 0 : 1)
                        .onChange(of: wkWebViewControlsVM.wkWebView?.url) { _, newValue in
                            if let url = newValue {
                                if url.absoluteString.starts(with: "https://www.amazon.com/gp/yourstore/home?path=") {
                                    dismiss()
                                    wkWebViewControlsVM.loadWebView(url: primeVideoPlaces.primeURL)
                                }
                            }
                        }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Group {
                        Button {
                            wkWebViewControlsVM.goBack()
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        .padding(.trailing, 5)
                        
                        Button {
                            wkWebViewControlsVM.goForward()
                        } label: {
                            Image(systemName: "chevron.right")
                        }
                        
                        Spacer()
                        
                        Button {
                            wkWebViewControlsVM.reload()
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                        }
                    }
                    .buttonBorderShape(.circle)
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}

#Preview {
    LoginView(isLoading: .constant(false), primeVideoPlaces: .constant(.home))
}
