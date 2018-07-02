//
//  ViewController.swift
//  TestWebMessages
//
//  Created by Kristaps Grinbergs on 26/06/2018.
//  Copyright © 2018 fassko. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let wkWebConfig = WKWebViewConfiguration()
    let wkUserController = WKUserContentController()
    
    wkWebConfig.userContentController = wkUserController
    
    let webView = WKWebView(frame: view.frame, configuration: wkWebConfig)
    view.addSubview(webView)
    
    let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource:"index", ofType: "html")!)
    webView.loadFileURL(fileURL, allowingReadAccessTo: fileURL)
    
    wkUserController.add(self, name: "notifications")
  }
}

extension ViewController: WKScriptMessageHandler {
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    print(message.frameInfo)
    print(message.webView)
    
    print(message.name)
    print(message.body)
    
    if let messageBodyDict = message.body as? [String: Any],
      let action = messageBodyDict["action"] as? String
      {
        print(action)
    }
  }
}

