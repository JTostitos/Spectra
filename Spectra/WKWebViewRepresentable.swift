//
//  WKWebViewRepresentable.swift
//  Spectra
//
//  Created by Jonathan Tsistinas on 2/3/24.
//

import SwiftUI
import WebKit


struct WKWebViewRepresentable: UIViewRepresentable {
    let url: URL
    let wkWebViewControlsVM: WKWebViewControlsVM
    @Binding var isLoading: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let wkWebView = WKWebView(frame: .zero, configuration: wkWebViewConfiguration())
        
        let customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_3_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.2 Safari/605.1.15"
        wkWebView.setValue(customUserAgent, forKey: "customUserAgent")
        
        wkWebView.navigationDelegate = context.coordinator
        
        wkWebView.scrollView.backgroundColor = .clear
        wkWebView.isOpaque = false
        wkWebView.underPageBackgroundColor = .clear
        
        wkWebViewControlsVM.wkWebView = wkWebView
        
        
        wkWebView.load(URLRequest(url: url))
        return wkWebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WKWebViewRepresentable
        init(_ parent: WKWebViewRepresentable) {
            self.parent = parent
        }
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }
    }
    
    func wkUserScript() -> WKUserScript {
        guard let path = Bundle.main.path(forResource: "style", ofType: "css") else {
            return WKUserScript()
        }
        
        let css = try! String(contentsOfFile: path).components(separatedBy: .newlines).joined()
        let source = """
        var style = document.createElement('style'); style.innerHTML = '\(css)'; document.head.appendChild(style);
        Object.defineProperty(navigator, 'maxTouchPoints', { get:function() { return 1; } });
        """
        
        let userScript = WKUserScript(source: source,
                                      injectionTime: .atDocumentEnd,
                                      forMainFrameOnly: false)
        
        return userScript
    }
    
    func fixVideoPlayer() -> WKUserScript {
        let source = """
        Object.defineProperty(navigator, 'maxTouchPoints', { get:function() { return 1; } });
        """
        
        let userScript = WKUserScript(source: source,
                                      injectionTime: .atDocumentStart,
                                      forMainFrameOnly: false)
        
        return userScript
    }
    
    func primeHeadersStyling() -> WKUserScript {
        let source = """
        var targetElement = document.getElementById('navbar-main');
        if (targetElement) {
        targetElement.style.display = 'none';
        } else {
        console.log("Target element not found.");
        };
        
        var targetElement = document.getElementById('pv-navigation-bar');
        if (targetElement) {
        targetElement.style.display = 'none';
        } else {
        console.log("Target element not found.");
        };
        
        var targetElement = document.getElementsByClassName('dynamic-type-ramp');
        if (targetElement) {
        for (var i = 0; i < targetElement.length; i++) {
        var carosel = targetElement[i].querySelector('div:nth-child(2)');
        
        if (carosel) {
                   carosel.style['padding-top'] = '5%';
        }
        }
        } else {
        console.log("Target element not found.");
        };
        """
        
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        
        return userScript
    }
    
    func primeFootersStyling() -> WKUserScript {
        let source = """
        var targetElement = document.getElementById('navFooter');
        if (targetElement) {
        targetElement.style.display = 'none';
        } else {
        console.log("Target element not found.");
        };
        """
        
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        
        return userScript
    }
    
    func episodesElementStyling() -> WKUserScript {
        let source = """
        /* This runs after a web page loads */
        var targetElement = document.getElementById('tab-content-episodes');
        if (targetElement) {
        
            // targetElement.style['background-color'] = 'rgba(205,25,105, 0.8)';
            targetElement.style.margin = '0';
        
        // Get the checkbox element by its ID
        var checkbox = document.getElementById('av-droplist-sorting-droplist');
        
        // Check if the checkbox element exists
        if (checkbox) {
            // Get the parent element of the checkbox
            var parentElement = checkbox.parentNode;
        
            // Check if the parent element exists
            if (parentElement) {
                // Set the display property of the parent element to 'none'
                parentElement.style.display = 'none';
            } else {
                console.error("Parent element not found.");
            }
        } else {
            console.error("Checkbox element not found.");
        }
        
        var liElements = targetElement.getElementsByTagName('li');
        
            for (var i = 0; i < liElements.length; i++) {
        
                liElements[i].style['max-width'] = '1200px';
                var divElement = liElements[i].querySelector('div');
        
                if (divElement) {
                    // divElement.style.padding = '24px';
                    //Set the box shadow and background to clear to remove the expanding view (kinda).
                    divElement.style['background-color'] = 'rgba(0,0,0, 0.0)';
                    divElement.style['box-shadow'] = '0 0px 0px 0px rgba(0,0,0,0)';
                    
                    // divElement.style.height = '300px';
        
                    var downloadDiv = divElement.querySelector('div:nth-child(3)');
                    if (downloadDiv) {
                        downloadDiv.style.display = 'none';
                    }
        
                    var episodeTitle = divElement.querySelector('div:nth-child(5)');
                    if (episodeTitle) {
                        episodeTitle.style.color = 'white';
                    }
        
                    var episodeDescription = divElement.querySelector('div:nth-child(6)');
                    if (episodeDescription) {
                        episodeDescription.style.color = 'white';
                    }
        
                    var episodePrimeButton = divElement.querySelector('div:nth-child(7)');
                    if (episodePrimeButton) {
                        episodePrimeButton.style.color = 'white';
                    }
        
                    var offersDiv = divElement.querySelector('div:nth-child(8)');
                    if (offersDiv) {
                        offersDiv.style.display = 'none';
                    }
        
                }
            }
        } else {
        console.log("Target element not found.");
        }
        """
        
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        
        return userScript
    }
    
    func episodeActionBoxStyling() -> WKUserScript {
        let source = """
        var targetElement = document.querySelector('.dv-dp-node-playback');
        
        if (targetElement) {
        var parent = targetElement.parentNode;
        if (parent) {
        var purchaseOptions = parent.querySelector('div:nth-child(2)');
        if (purchaseOptions) {
            purchaseOptions.style.display = 'none';
        }
        
        }
        } else {
        console.log("Target element not found.");
        }
        """
        
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
    }
    
    func downloadEpisodeUnavailableActionBoxStyling() -> WKUserScript {
        let source = """
        var targetElement = document.querySelector('.dv-node-dp-action-box');
        
        if (targetElement) {
        var divElement = targetElement.getElementsByTagName('div');
        if (divElement) {
        divElement[4].style.display = 'none';
        }
        } else {
        console.log("Target element not found.");
        }
        """
        
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
    }
    
    func removeWatchPartyButtonStyling() -> WKUserScript {
        let source = """
        var targetElement = document.querySelector('.dv-dp-node-watchparty');
        
        if (targetElement) {
        targetElement.style.display = 'none';
        } else {
        console.log("Target element not found.");
        }
        """
        
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
    }
    
    func wkWebViewConfiguration() -> WKWebViewConfiguration {
        let userContentController = WKUserContentController()
        
        userContentController.addUserScript(wkUserScript())
        userContentController.addUserScript(primeHeadersStyling())
        userContentController.addUserScript(fixVideoPlayer())
        userContentController.addUserScript(episodesElementStyling())
        userContentController.addUserScript(primeFootersStyling())
        userContentController.addUserScript(downloadEpisodeUnavailableActionBoxStyling())
        userContentController.addUserScript(episodeActionBoxStyling())
        userContentController.addUserScript(removeWatchPartyButtonStyling())
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        return configuration
    }
 
}
