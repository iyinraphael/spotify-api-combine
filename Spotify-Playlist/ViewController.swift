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

    @IBOutlet var webView: WKWebView!

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

    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Work", style: .done, target: self, action: #selector(presentSpotifyScreen))
    }

    @objc func presentSpotifyScreen() {
        let vc = SpotifyViewController()
        present(vc, animated: true)
    }
}

extension ViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let url = webView.url,
        let token = url.query?.dropFirst(5) else { return }

        UserDefaults.standard.set(token, forKey: "Authorization")
    }
}
