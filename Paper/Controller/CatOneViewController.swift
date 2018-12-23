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
    let searchController = UISearchController(searchResultsController: nil)
    var courseName : [String] = []
    var courseCode:[String] = []
    var filteredObjects = [data]()
    
    @IBOutlet weak var headLabel: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = type
        initialise()
        get()
        table.delegate = self
        table.dataSource = self
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = UIColor.white
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = " by Corse Name or Code"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
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
          
                while(self.i<json.count){
                    self.val = json
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
}


//MARK: - Table View Methods

extension CatOneViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering(){
            return filteredObjects.count
        }
        
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
        let dataa : data
        if objArray.count>0{
            cell.button.tag = indexPath.section
            cell.button.backgroundColor = .white
            if isFiltering(){
                dataa = filteredObjects[indexPath.section]
            }
            else{
                dataa = objArray[indexPath.section]
            }
            cell.courseCode.text = dataa.code
            cell.courseName.text = dataa.name
            cell.slot.text = dataa.slot
            cell.year.text = dataa.year
            courseCode.append(objArray[indexPath.section].name)
            courseName.append(objArray[indexPath.section].code)
            filteredObjects.append(objArray[indexPath.section])
           
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

extension CatOneViewController:UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    
    }
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredObjects = objArray.filter({ (data : data) -> Bool in
            return data.name.lowercased().contains(searchText.lowercased()) || data.code.lowercased().contains(searchText.lowercased())
        })
        table.reloadData()
    }
    
    func isFiltering()->Bool{
        
        return searchController.isActive && !searchBarIsEmpty()
    }
}



