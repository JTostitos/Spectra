//
//  WKWebViewControlsVM.swift
//  Spectra
//
//  Created by Jonathan Tsistinas on 2/9/24.
//

import SwiftUI
import Observation

enum PrimeVideoURLS: CaseIterable {
    case login, home, live, stuff
    
    var url: String {
        switch self {
            case .login:
                "https://www.amazon.com/ap/signin?openid.pape.max_auth_age=0&openid.return_to=https%3A%2F%2Fwww.amazon.com%2FAmazon-Video%2Fb%3Fie%3DUTF8%26node%3D2858778011%26ref_%3Dnav_custrec_signin&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.assoc_handle=usflex&openid.mode=checkid_setup&openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0"
            case .home:
                "https://www.amazon.com/gp/video/storefront"
            case .live:
                "https://www.amazon.com/gp/video/storefront?contentType=home&contentId=live"
            case .stuff:
                "https://www.amazon.com/gp/video/mystuff"
        }
    }
}

@Observable
class WKWebViewControlsVM {
    static let shared = WKWebViewControlsVM()
    
    var selectedPrimeVideoURL: PrimeVideoURLS = .home
    
    var oldURL: String = ""
    var newURL: String = ""
 
    func navigate(to primeVideoURL: PrimeVideoURLS) {
        newURL = primeVideoURL.url
    }
    
}
