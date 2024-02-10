//
//  ContentView.swift
//  Spectra
//
//  Created by Jonathan Tsistinas on 2/3/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

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
}

struct ContentView: View {
    @AppStorage("loggedIn") var loggedIn: Bool = false
    @State private var currentURL: PrimeVideoPlaces = .home
    @State private var wkWebControlsVM = WKWebViewControlsVM.shared
    
    var body: some View {
        WKWebViewRepresentable(url: URL(string: wkWebControlsVM.selectedPrimeVideoURL.url)!)
            .frame(width: 1400, height: 1000, alignment: .center)
            .ornament(attachmentAnchor: .scene(.leading)) {
                VStack(spacing: 32) {
                    ForEach(PrimeVideoPlaces.allCases, id: \.hashValue) { prime in
                        Button {
                            
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
                            
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        
                        Text(currentURL.tabItemNames)
                            .frame(minWidth: 100)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "chevron.right")
                        }
                    }
                    .buttonBorderShape(.circle)
                    .buttonStyle(.bordered)
                }
            }
        
        
//                if loggedIn {
//                    WKWebViewRepresentable(url: URL(string: "https://www.amazon.com/ap/signin?openid.pape.max_auth_age=0&openid.return_to=https%3A%2F%2Fwww.amazon.com%2FAmazon-Video%2Fb%3Fie%3DUTF8%26node%3D2858778011%26ref_%3Dnav_custrec_signin&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.assoc_handle=usflex&openid.mode=checkid_setup&openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0")!)
//                        .tabItem { Label("Login", systemImage: "ellipsis.rectangle") }
//                } else {
//                    WKWebViewRepresentable(url: URL(string: prime.url)!)
//                }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
