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
        initialiseBUtton()
    }
    
    func initialiseBUtton(){
        let camera = UIBarButtonItem(barButtonSystemItem: .save, target: self, action:  #selector(self.savePressed(sender:)))
        self.navigationItem.rightBarButtonItem = camera
    }
    
    @objc func savePressed(sender : UIButton!){
        savePdf()
    }
    
    func savePdf(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("paper-VIT.pdf")
        let pdfDoc = NSData(contentsOf:URL(string: stringPassed)!)
        fileManager.createFile(atPath: paths as String, contents: pdfDoc as Data?, attributes: nil)
        print("Saved",paths as String)
        loadPDFAndShare()
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func loadPDFAndShare(){
        
        let fileManager = FileManager.default
        let documentoPath = (self.getDirectoryPath() as NSString).appendingPathComponent("documento.pdf")
        
        if fileManager.fileExists(atPath: documentoPath){
            let documento = NSData(contentsOfFile: documentoPath)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView=self.view
            present(activityViewController, animated: true, completion: nil)
        }
        else {
            print("document was not found")
        }
    }
    
    func showPage(){
        print("String =  ",stringPassed)
        let URL:NSURL = NSURL(string: stringPassed)!
        let req = URLRequest(url: URL as URL)
        webView.load(req)
        
    }

}
