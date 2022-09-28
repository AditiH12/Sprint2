//
//  CategoryViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/25/22.
//

import UIKit
import Alamofire

class CategoryViewController: UIViewController {         //Class to display different items in the Category tab begins.

    
    @IBOutlet weak var ItemsInTableView: UITableView!     //Outlet for TableView.
    
    var itemsName=[String]()  // Array to store items.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSONData()      //Calling the function to fetch data.
        // Do any additional setup after loading the view.
    }
    
   func fetchJSONData(){            //  Function to fetch JSON Data from Alamofire.
       
       Alamofire.request("https://dummyjson.com/products/categories", method: .get, encoding: URLEncoding.default, headers: nil).responseJSON{
           (response) in
           switch response.result
           {
           case .success:
               let data : NSArray = response.result.value as! NSArray
               for index in 0...data.count-1
               {
                   self.itemsName.append((data[index] as AnyObject).stringValue)
                 //  print(self.itemName)
               }
               print(self.itemsName)
               self.ItemsInTableView.reloadData()
           case .failure:
               print("Error while fetching JSON")
           }
     }
   }
}

extension CategoryViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tablView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsName.count
 
    }
    func tableView(_ tablView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ItemsInTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = itemsName[indexPath.row]
        return cell
  }
    func tableView(_ tablView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "AddToCartViewController") as? AddToCartViewController
        VC?.itemabc = itemsName[indexPath.row]
        self.navigationController?.pushViewController(VC!, animated: true)
  }
}
