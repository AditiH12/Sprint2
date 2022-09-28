//
//  AddToCartViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/26/22.
//

import UIKit
import Alamofire
import CoreData
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class AddToCartViewController: UIViewController {

    //var url: String = "https://dummyjson.com/products/category/smartphones"
    var url = "https://dummyjson.com/products/category/"
    var items = [[String: Any]]()
    var itemabc = ""
    var nameData = ""
    var DescriptionData = ""
    //var regName = [String?]()
    
    
    
    
    @IBOutlet weak var AddtoCartItemsTable: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Category", style: .plain, target: nil, action: nil)
        url = url + itemabc
       fetchDataOfItems()
        
        
        // Do any additional setup after loading the view.
    }
    
    
 /*  @IBAction func AddingToCartBtnClicked(_ sender: Any) {
        let itemInformationDict = ["title": a,"descript": b]
        save(object: itemInformationDict as! [String: String])
        print(itemInformationDict)
    }*/
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func save(object: [String : String]){
        let information = NSEntityDescription.insertNewObject(forEntityName: "Products", into: context!) as! Products
        information.userEmailID = object["userEmailID"]
        information.productName = object["productName"]
        information.productDescription = object["productDescription"]
        do{
            try context?.save()
        }catch{
            print("Data not saved")
        }
    }
    
    func fetchDataOfItems(){
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil).responseJSON {
            (response) in
           // print(response.result)
            switch response.result
            {
            case .success:
                if let json = response.result.value as! [String: Any]?{
                    if let responseValue = json["products"] as! [[String: Any]]?{
                    self.items = responseValue
                    self.AddtoCartItemsTable.reloadData()
                }
            }
            
        case .failure:
            print("Error fetching JSON Data")
        }
    }
}

}  // end of class.

extension AddToCartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = AddtoCartItemsTable.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as! AddToCartTableViewCell
        cells.itemNameLabel.text = items[indexPath.row]["title"] as? String
        cells.itemDescriptionLabel.text = items[indexPath.row]["description"] as? String
        cells.addingToCartBtnClicked.tag = indexPath.row
        cells.addingToCartBtnClicked.addTarget(self, action: #selector(cartButtonFunction), for: .touchUpInside)
        return cells
    }
    
    @objc func cartButtonFunction(sender: UIButton)
    {
        let indexpath1 = IndexPath(row: sender.tag, section: 0)
        nameData = items[indexpath1.row]["title"] as! String
        DescriptionData = items[indexpath1.row]["description"] as! String
        
        let userEmail = Auth.auth().currentUser?.email
        let detailsDict = ["userEmailID": userEmail, "productName": nameData, "productDescription": DescriptionData]
        print(detailsDict)
        save(object: detailsDict as! [String:String])
        
        let cartvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondCartViewController") as! SecondCartViewController
        
        self.navigationController?.pushViewController(cartvc, animated: true)
    }
    
}
