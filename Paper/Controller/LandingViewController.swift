//
//  LandingViewController.swift
//  Paper
//
//  Created by Tushar Singh on 10/12/18.
//  Copyright © 2018 Tushar Singh. All rights reserved.
//

import UIKit
import MessageUI
import MobileCoreServices


class LandingViewController: UIViewController,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var catOne: UIButton!
    @IBOutlet weak var catTwo: UIButton!
    @IBOutlet weak var fat: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var catOneLabel: UILabel!
    @IBOutlet weak var catTwoLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var aboutUsButton: UIButton!
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var catOneSubView: UIView!
    @IBOutlet weak var catTwoSubview: UIView!
    @IBOutlet weak var fatSubView: UIView!
    
    var buttonVal=0
    var typeSelected = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 55.0/255.0, green: 67.0/255.0, blue: 77.0/255.0, alpha: 1.0)
        catOneSubView.layer.cornerRadius = 15
        catTwoSubview.layer.cornerRadius = 15
        fatSubView.layer.cornerRadius = 15
        donateButton.layer.cornerRadius=10
        lineView.layer.cornerRadius = 5
        aboutUsButton.layer.cornerRadius = 10
//        donateButton.isEnabled = false
//        donateButton.isHidden = true
        
    }
    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(buttonVal==1){
            let SB:CatOneViewController = segue.destination as! CatOneViewController
            SB.type = typeSelected
            buttonVal=0
            }
        

        }
        
    
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
            case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
            case MFMailComposeResult.saved.rawValue:
            print("Saved")
            case MFMailComposeResult.sent.rawValue:
            print("Sent")
            case MFMailComposeResult.failed.rawValue:
            print("Error: \(String(describing: error?.localizedDescription))")
            default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }

    private func attachDocument() {
        let types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet]
        let importMenu = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
        
        if #available(iOS 11.0, *) {
            importMenu.allowsMultipleSelection = true
        }
        
        importMenu.delegate = self as! UIDocumentPickerDelegate
        importMenu.modalPresentationStyle = .formSheet
        
        present(importMenu, animated: true)
    }

    func sendMail(url:URL){
                if MFMailComposeViewController.canSendMail() {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients(["adgpapervit@gmail.com"])
                    mail.setSubject("I have done my part")
                    mail.setMessageBody("<b>This is my part</b>", isHTML: true)
                    let filePath = url.absoluteString
                    do{
                        let fileData = try Data(contentsOf: url)
                        print(url)
                        let fileName = (filePath as NSString).lastPathComponent
                        mail.addAttachmentData(fileData, mimeType: "application/pdf", fileName: fileName)
                    }catch{
                        print("Error ",error)
                    }
                    present(mail, animated: true, completion: nil)
                } else {
                    print("Cannot send mail")
                    // give feedback to the user
                }
       
    }
    
    
    @IBAction func cat1(_ sender: Any) {
        catOne.bringSubviewToFront(self.view)
        typeSelected = catOneLabel.text!
        buttonVal=1
        performSegue(withIdentifier: "cat1", sender: nil)
    }
    
   
    @IBAction func cat2(_ sender: Any) {
        
        typeSelected = catTwoLabel.text!
        buttonVal=1
        performSegue(withIdentifier: "cat1", sender: nil)
    }
    
    @IBAction func fat(_ sender: Any) {
        typeSelected = fatLabel.text!
        buttonVal=1
        performSegue(withIdentifier: "cat1", sender: nil)

    }
    
    @IBAction func donate(_ sender: Any) {
        attachDocument()

    }
    

    @IBAction func aboutUs(_ sender: Any) {
        
        performSegue(withIdentifier: "about", sender: nil)
    }
}

extension LandingViewController: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        //view.attachDocuments(at: urls)
        
        sendMail(url:urls[0])
        
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
    

