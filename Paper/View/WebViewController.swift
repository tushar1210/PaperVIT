//
//  WebViewController.swift
//  Paper
//
//  Created by Tushar Singh on 14/12/18.
//  Copyright © 2018 Tushar Singh. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController{

    @IBOutlet weak var webView: WKWebView!
    
    var stringPassed = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        showPage()
       
    }
    

    
    func showPage(){
        print("String =  ",stringPassed)
        let URL:NSURL = NSURL(string: stringPassed)!
        let req = URLRequest(url: URL as URL)
        webView.load(req)
    }
    
    

}
