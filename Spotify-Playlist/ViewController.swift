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
    static let identifier = "SpotifyViewController"

    @IBOutlet var webView: WKWebView!

    @IBOutlet weak var showBarButtonItem: UIBarButtonItem?

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


    @IBAction func showSpotifyVC(_ sender: Any) {
        performSegue(withIdentifier: Self.identifier, sender: self)
    }

    @IBSegueAction func makeSpotifyViewController(_ coder: NSCoder, _ sender: Any?, _ segueIdentifier: String?) -> UIViewController? {
        return SpotifyViewController(coder: coder)
    }
}

extension ViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let url = webView.url,
        let token = url.query?.dropFirst(5) else { return }

        UserDefaults.standard.set(token, forKey: "Authorization")
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let isActivate = navigationAction.request.url?.pathComponents.contains("authorize") else { return }

        showBarButtonItem?.isEnabled = !isActivate

        decisionHandler(WKNavigationActionPolicy.allow)
    }
}
