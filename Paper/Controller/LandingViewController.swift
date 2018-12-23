//
//  LandingViewController.swift
//  Paper
//
//  Created by Tushar Singh on 10/12/18.
//  Copyright © 2018 Tushar Singh. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var catOne: UIButton!
    @IBOutlet weak var catTwo: UIButton!
    @IBOutlet weak var fat: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var catOneLabel: UILabel!
    @IBOutlet weak var catTwoLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var aboutUsButton: UIButton!
    
    
    var typeSelected = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 55.0/255.0, green: 67.0/255.0, blue: 77.0/255.0, alpha: 1.0)
        catOne.layer.cornerRadius = 20
        catTwo.layer.cornerRadius = 20
        fat.layer.cornerRadius = 20
        lineView.layer.cornerRadius = 5
        aboutUsButton.layer.cornerRadius = 15
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let SB:CatOneViewController = segue.destination as! CatOneViewController
        SB.type = typeSelected
    }
    
    @IBAction func cat1(_ sender: Any) {
        typeSelected = catOneLabel.text!
        print(typeSelected)
        performSegue(withIdentifier: "cat1", sender: nil)
    }
    
   
    @IBAction func cat2(_ sender: Any) {
        typeSelected = catTwoLabel.text!
        performSegue(withIdentifier: "cat1", sender: nil)
    }
    
    @IBAction func fat(_ sender: Any) {
        typeSelected = fatLabel.text!
        performSegue(withIdentifier: "cat1", sender: nil)

    }
}
