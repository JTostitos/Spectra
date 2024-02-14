//
//  LoginView.swift
//  Spectra
//
//  Created by Jonathan Tsistinas on 2/13/24.
//

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
                        .onChange(of: wkWebViewControlsVM.wkWebView?.url) { oldValue, newValue in
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
