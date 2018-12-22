//
//  CatOneViewController.swift
//  Paper
//
//  Created by Tushar Singh on 10/12/18.
//  Copyright © 2018 Tushar Singh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CatOneViewController: UIViewController,TableViewCellDelegate {

    
    var type = ""
    var url = "http://namankhurpia.pythonanywhere.com/catone/"
    var baseURL = "http://namankhurpia.pythonanywhere.com"
    var objArray = [data]()
    var i = 0
    var ip = 0
    var val:JSON = []
    var buttonIsSelected = [Bool](repeating: false, count: 5000)
    var finalPath = ""
    var sortedCorse = ["":[""]]

    @IBOutlet weak var headLabel: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = type
        initialise()
        get()
        
        table.delegate = self
        table.dataSource = self
    }
    
    
    func initialise(){
      //  print("In   \(type)")
        switch type {
        case "CAT1":
            url = "http://namankhurpia.pythonanywhere.com/catone/";
            headLabel.text = "Continuous Assessment Test 1"
            break;
            
        case "CAT2":
            url = "http://namankhurpia.pythonanywhere.com/cattwo/";
            headLabel.text = "Continuous Assessment Test 2"
            break;
            
        case "FAT":
            url = "http://namankhurpia.pythonanywhere.com/fat/"
            headLabel.text = "Final Assessment Test "
        default:
            url = "https://www.google.com"
            headLabel.text = ""
        }
        
    }
    
    func get(){ 
        
        Alamofire.request(self.url, method: .get).responseJSON { (response) in
            if(response.result.isSuccess){
                let json = JSON(response.result.value!)
                self.val = json
               // print(json.count)
            
            while(self.i<json.count){

                let obj = data()
                obj.name = json[self.i]["course_name"].stringValue
                obj.code = json[self.i]["course_code"].stringValue
                obj.slot = json[self.i]["slot"].stringValue
                obj.year = json[self.i]["year"].stringValue
                obj.id = json[self.i]["id"].intValue
                obj.dataDir = json[self.i]["data_dir"].stringValue
                self.objArray.append(obj)
                
                self.table.reloadData()
                self.i+=1
                
                }
                self.sortCourse(json : self.val)
            }
        }
        
    }
    func CreateLink(pos:Int){
        let path = baseURL+objArray[pos].dataDir
        finalPath = path
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let WebViewVC : WebViewController = segue.destination as! WebViewController
        WebViewVC.stringPassed = finalPath
    }

    func sortCourse(json : JSON){
        print("VAL = ",json.count)
        
    }
    
    
}







//MARK: - Table View Methods

extension CatOneViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objArray.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.layer.cornerRadius = 20
        cell.isUserInteractionEnabled = true
        cell.cellDelegate = self
       
        if objArray.count>0{
            cell.button.tag = indexPath.section
            cell.button.backgroundColor = .white
            cell.courseCode.text = objArray[indexPath.section].code
            cell.courseName.text = objArray[indexPath.section].name
            cell.slot.text = objArray[indexPath.section].slot
            cell.year.text = objArray[indexPath.section].year
            if buttonIsSelected[indexPath.section] == true{
                //cell.button.backgroundColor = .green
            }
            else{
                cell.button.backgroundColor = .white
            }
        }
        return cell
    }
    
    
    func didPressButton(_ tag: Int) {
        checkIsSelected(ip : tag)
        performSegue(withIdentifier: "web", sender: nil)

    }
    
    func checkIsSelected(ip: Int){
        buttonIsSelected[ip] = true
        table.reloadData()
        CreateLink(pos: ip)

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
        
    }
}





