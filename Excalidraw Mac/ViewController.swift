//
//  ViewController.swift
//  Excalidraw Mac
//
//  Created by Jed Fox on 3/25/20.
//  Copyright © 2020 Jed Fox. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    @IBOutlet weak var progressBar: ProgressBar!
    @IBOutlet weak var webView: WKWebView!
    
    var progressObservation: NSKeyValueObservation?
    var loadingObservation: NSKeyValueObservation?
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.load(URLRequest(url: URL(string: "https://excalidraw.com")!))
        progressObservation = observe(\ViewController.webView.estimatedProgress) { (_, _) in
            NSAnimationContext.runAnimationGroup { (context) in
                context.allowsImplicitAnimation = true
                self.progressBar.progress = CGFloat(self.webView.estimatedProgress)
            }
        }
        loadingObservation = observe(\ViewController.webView.isLoading) { (_, _) in
            NSAnimationContext.runAnimationGroup { (context) in
                context.allowsImplicitAnimation = true
                self.progressBar.alphaValue = self.webView.isLoading ? 1 : 0
            }
        }
    }

}

