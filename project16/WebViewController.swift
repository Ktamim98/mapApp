//
//  WebViewController.swift
//  project16
//
//  Created by Tamim Khan on 12/3/23.
//
import WebKit
import UIKit

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var webView: WKWebView!
    var urlString: String?
           
           override func loadView() {
               webView = WKWebView()
               webView.navigationDelegate = self
               view = webView
           }
           
           override func viewDidLoad() {
               super.viewDidLoad()
               
               guard let urlString = urlString, let url = URL(string: urlString) else {
                   print("Invalid URL string")
                   return
               }
               
               webView.load(URLRequest(url: url))
               webView.allowsBackForwardNavigationGestures = true
           }
       }
