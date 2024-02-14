//
//  ContentView.swift
//  Spectra
//
//  Created by Jonathan Tsistinas on 2/3/24.
//

import SwiftUI
import WebKit

enum PrimeVideoPlaces: CaseIterable {
    case home, live, stuff, profile
    
    var tabItemNames: String {
        switch self {
            case .home:
                return "Home"
            case .live:
                return "Live"
            case .stuff:
                return "My stuff"
            case .profile:
                return "Profile"
        }
    }
    
    var tabItemImages: String {
        switch self {
            case .home:
                return "house"
            case .live:
                return "play.tv.fill"
            case .stuff:
                return "tray.full"
            case .profile:
                return "person"
        }
    }
    
    var primeURL: String {
        switch self {
            case .home:
                return "https://www.amazon.com/gp/video/storefront"
            case .live:
                return "https://www.amazon.com/gp/video/storefront?contentType=home&contentId=live"
            case .stuff:
                return "https://www.amazon.com/gp/video/mystuff"
            case .profile:
                return "https://www.amazon.com/gp/video/profiles?step=manage"
        }
    }
    
    var loginURL: String {
        return "https://www.amazon.com/ap/signin?openid.pape.max_auth_age=900&openid.return_to=https://www.amazon.com/gp/yourstore/home?path%3D%252Fgp%252Fyourstore%252Fhome%26signIn%3D1%26useRedirectOnSuccess%3D1%26action%3Dsign-out%26ref_%3Dnav_AccountFlyout_signout&openid.assoc_handle=usflex&openid.mode=checkid_setup&openid.ns=http://specs.openid.net/auth/2.0"
    }
}

struct ContentView: View {
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openWindow) var openWindow
    @Environment(WKWebViewControlsVM.self) var wkWebViewControlsVM
    @AppStorage("requiresLogin") private var requiresLogin: Bool = true
    @State private var primeVideoPlaces: PrimeVideoPlaces = .home
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            
            if !requiresLogin {
                if let url =  URL(string: "https://www.amazon.com/gp/video/storefront") {
                    WKWebViewRepresentable(url: url, wkWebViewControlsVM: wkWebViewControlsVM, isLoading: $isLoading)
                        .opacity(isLoading ? 0 : 1)
                        .ornament(attachmentAnchor: .scene(.leading)) {
                            VStack(spacing: 32) {
                                ForEach(PrimeVideoPlaces.allCases, id: \.hashValue) { prime in
                                    Button {
                                        wkWebViewControlsVM.loadWebView(url: prime.primeURL)
                                    } label: {
                                        Image(systemName: prime.tabItemImages)
                                            .font(.title)
                                            .frame(width: 60, height: 60)
                                    }
                                    .buttonStyle(.borderless)
                                    .buttonBorderShape(.circle)
                                }
                            }
                            .padding()
                            .glassBackgroundEffect()
                        }
                        .toolbar {
                            ToolbarItemGroup(placement: .bottomOrnament) {
                                Group {
                                    Button {
                                        wkWebViewControlsVM.goBack()
                                    } label: {
                                        Image(systemName: "chevron.left")
                                    }
                                    
                                    Text(wkWebViewControlsVM.webpageTitle())
                                        .frame(minWidth: 100)
                                    
                                    Button {
                                        wkWebViewControlsVM.goForward()
                                    } label: {
                                        Image(systemName: "chevron.right")
                                    }
                                    
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
                        .onChange(of: wkWebViewControlsVM.wkWebView?.url) { oldValue, newValue in
                            if let url = newValue {
                                if url.absoluteString.contains("https://www.amazon.com/gp/video/detail") {
                                    openWindow(id: "videoPlayerView", value: url.absoluteString)
                                    wkWebViewControlsVM.goBack()
                                }
                            }
                        }
                }
            }
        }
        .onAppear {
            dismissWindow(id: "videoPlayerView")
        }
        .sheet(isPresented: $requiresLogin) {
            LoginView(isLoading: $isLoading, primeVideoPlaces: $primeVideoPlaces)
                .environment(wkWebViewControlsVM)
                .frame(width: 575, height: 575)
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
