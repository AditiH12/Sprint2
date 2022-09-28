//
//  CartViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/25/22.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class CartViewController: UIViewController {
    
 
    @IBOutlet weak var cartTableView: UITableView!
    
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var details = [Products]()
    let userEmail = Auth.auth().currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.navigationItem.hidesBackButton = false
        // Do any additional setup after loading the view.

       
    let emailIP = NSPredicate(format: "userEmailID matches %@", userEmail as! String)
    
        let fetchDetails1 = NSFetchRequest<NSManagedObject>(entityName: "Products")
        fetchDetails1.predicate = emailIP
        do{
            details = try context?.fetch(fetchDetails1) as! [Products]
        }catch{
            print("Cannot get data")
        }
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        
    }

    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hi")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InCartTableViewCell
        cell.ItemNameInCart.text = self.details[indexPath.row].productName
        cell.ItemDescriptionInCart.text = self.details[indexPath.row].productDescription
        
        return cell
    }
    
    
}
