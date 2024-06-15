//
//  Spotify.swift
//  Docs
//
//  Created by Regin Maru on 07/05/2024.
//

import Foundation
import SwiftUI
import WebKit

struct SpotifyBuilder: UIViewRepresentable {
    let url: String
    private static var webView: WKWebView?
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let htmlString = getSpotifyString()
        
        webView.navigationDelegate = context.coordinator
        webView.loadHTMLString(htmlString, baseURL: nil)
        print("done")
        SpotifyBuilder.webView = webView
        return webView
    }
    
    func getSpotifyString() -> String {
        return """
            <script src="https://open.spotify.com/embed/iframe-api/v1" async></script>
            
            <div id="embed-iframe"></div>
            
            <script>
              let controller;
              window.onSpotifyIframeApiReady = IFrameAPI => {
                const element = document.getElementById('embed-iframe');
                const options = {
                  uri: \(url),
                };
                const callback = EmbedController => {
                  controller = EmbedController;
                  controller.addListener('ready', () => {
                    console.log('ready');
                    controller.play(); // Automatically play the track when ready
                  });
                };
                IFrameAPI.createController(element, options, callback);
              };
            </script>
            """
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {Coordinator()}
    
    class Coordinator: NSObject, WKNavigationDelegate {}
    
    /* Important function if you want you preview to be invisible.
     Also the toggle for the iFrame is kinda bugged and it actually needs to be called twice the first time after the WebView has spawned.
     */
    static func togglePlayback() {
        guard let webView = webView else {
            print("not yet made")
            return
        }
        
        let jsCode = """
            // Get a reference to the embed iframe element
            var spotify = document.querySelector('iframe').contentWindow.postMessage({command: 'toggle'}, '*');
        """
        webView.evaluateJavaScript(jsCode)
    }
}

struct SpotifyView: View {
    let songURL: String
    let hide: Bool = true
    var body: some View {
        // Triple hide all the way across the sky
        SpotifyBuilder(url: songURL)
            .hide(hide: hide)
    }
}

func Spotify() -> Item {
    let title: String = "Create Spotify Preview"
    let desc: AnyView = AnyView(
        ScrollView {
            VStack {
                Text("Imports: WebKit, SwiftUI")
                    .doc()
                Text("Spotify has an API for it's music. So we need to create a View for this.")
                    .doc()
                SnippetView(content: SpotifyCode.view)
                Text("Create a struct that uses the UIViewRepresentable protocol. These are used to create WebViews.")
                    .doc()
                SnippetView(content: SpotifyCode.webview)
                Text("I'll be honest, I have no idea what half this code is meant to do. The only thing I know is that  in makeUIView you should load your html.")
                    .doc()
                Text("This is my spotify stringbuilder")
                    .doc()
                SnippetView(content: SpotifyCode.script)
                Text("If you wish to create your own custom View for the preview. you can hide the SpotifyView.")
                    .doc()
                SpotifyView(songURL: "https://open.spotify.com/track/3BtuIIrQlkujKPuWF2B85z?si=4b5fa20ee73c4ee2")
                Play()
                Text("Here is a play button to show the end result.")
                    .doc()
                
            }
        }
    )
    
    return Item(title: title, desc: desc)
}

struct Play: View {
    @State var isFirst: Bool = true
    @State var image: String = "play"
    var body: some View {
        ZStack(alignment: .leading) {
            Window()
                .stroke(Color(uiColor:.black), lineWidth: 3).frame(width: 300, height: 50)
            Button(action: {
                switchImage()
                SpotifyBuilder.togglePlayback()
            }) {
                Image(image)
                    .doc(width: 32, height: 32)
                    .padding([.leading, .bottom, .top])
            }
        }
    }
    
    func switchImage() -> Void {
        if(image == "play") {
            image = "pause"
        } else {
            image = "play"
        }
    }
}

class SpotifyCode {
    static let view: String = """
    struct SpotifyView: View {
        let songURL: String
        let hide: Bool = true
        var body: some View {
            // Triple hide all the way across the sky
            SpotifyBuilder(url: songURL)
                .hide(hide: hide)
        }
    }
    """
    static let webview: String = """
    import SwiftUI
    import WebKit

    struct SpotifyBuilder: UIViewRepresentable {
        let url: String
        private static var webView: WKWebView?
        
        func makeUIView(context: Context) -> WKWebView {
            let webView = WKWebView()
            let htmlString = getSpotifyString()
            
            webView.navigationDelegate = context.coordinator
            webView.loadHTMLString(htmlString, baseURL: nil)
            print("done")
            SpotifyBuilder.webView = webView
            return webView
        }
    """
    
    static let script: String = """
    func getSpotifyString() -> String {
        return \"""
            <script src="https://open.spotify.com/embed/iframe-api/v1" async></script>
            
            <div id="embed-iframe"></div>
            
            <script>
              let controller;
              window.onSpotifyIframeApiReady = IFrameAPI => {
                const element = document.getElementById('embed-iframe');
                const options = {
                  uri: \\(url),
                };
                const callback = EmbedController => {
                  controller = EmbedController;
                  controller.addListener('ready', () => {
                    console.log('ready');
                    controller.play(); // Automatically play the track when ready
                  });
                };
                IFrameAPI.createController(element, options, callback);
              };
            </script>
            \"""
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {Coordinator()}
    
    class Coordinator: NSObject, WKNavigationDelegate {}
    """
    
}


#Preview {
    VStack{
        Spotify().desc
    }
}
