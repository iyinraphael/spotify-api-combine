//
//  ViewController.swift
//  Spotify-Playlist
//
//  Created by Iyin Raphael on 2/7/23.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    let network = NetworkService()
    var webView: WKWebView?

    override func loadView() {
        super.loadView()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView?.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlRequest = network.getAccessToken()
        webView?.load(urlRequest)
    }
}

extension ViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        print("authorization url", url)
    }
}
