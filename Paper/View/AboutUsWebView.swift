//
//  AboutUsWebView.swift
//  Paper
//
//  Created by Tushar Singh on 07/02/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import WebKit

class AboutUsWebView: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showPage()
      
    }
    

    func showPage(){
        let url:NSURL = NSURL(string: "http://www.adgvit.com")!
        let req = URLRequest(url: url as URL)
        webview.load(req)
        
    }

}
