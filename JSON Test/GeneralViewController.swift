//
//  GeneralViewController.swift
//  JSON Test
//
//  Created by Dylan McDonald on 11/1/20.
//

import UIKit
import WebKit

class GeneralViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://github.com/DylanMcD8/SchoolAssistantAnnouncements/edit/main/general.json")
        webView.load(URLRequest(url: url!))
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        webView.reload()
        lightHaptics()
    }
    
}
