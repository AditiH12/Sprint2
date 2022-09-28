//
//  NewAddToCartViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/26/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewAddToCartViewController: UIViewController {

    
    @IBOutlet weak var ItemsTable: UITableView!
    
    var url: String = "https://dummyjson.com/products/category/smartphones"
    var itemsInCategory = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        // Do any additional setup after loading the view.
    }
    
    func fetchData(){
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil).responseJSON{
            (response) in
            print(response.result)
            switch response.result
            {
            case .success:
                if let json = response.result.value as! [String: Any]?{
                    if let responseValue = json["products"] as! [[String: Any]]?{
                    self.itemsInCategory = responseValue
                    self.ItemsTable.reloadData()
                }
            }
            
        case .failure:
            print("Error fetching JSON Data")
        }
      }
    }
}

extension NewAddToCartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsInCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = ItemsTable.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as! New_AddCartTableViewCell
        cells.itemNameLabelField.text = itemsInCategory[indexPath.row]["title"] as? String
        cells.itemDescriptionLabelField.text = itemsInCategory[indexPath.row]["description"] as? String
         return cells
        
    }
    
    
  /*  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsInCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = ItemsTable.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as! New_AddCartTableViewCell
        cells.itemNameLabelField.text = itemsInCategory[indexPath.row]["itemName"] as? String
        cells.itemDescriptionLabelField.text = itemsInCategory[indexPath.row]["itemDescriptionLabel"] as? String
         return cells
    }*/
}
