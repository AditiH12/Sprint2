//
//  SecondCartViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/28/22.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class SecondCartViewController: UIViewController {

    @IBOutlet weak var secondCartTable: UITableView!
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var info2 = [Products]()
    let userEmail = Auth.auth().currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(info2.count)
        
        self.secondCartTable.reloadData()
        secondCartTable.delegate = self
        secondCartTable.dataSource = self
        
        
        
        let emailIP = NSPredicate(format: "userEmailID MATCHES %@", userEmail!)
        
        let storeDetails = NSFetchRequest<NSManagedObject>(entityName: "Products")
        storeDetails.predicate = emailIP
        do{
            info2 = try context?.fetch(storeDetails) as! [Products]
            print(info2)
        }catch{
            print("Cannot get data")
        }
        DispatchQueue.main.async {
            self.secondCartTable.reloadData()
        }

    }
 
}

extension SecondCartViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hi")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(info2.count)
        return info2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celltwo = secondCartTable.dequeueReusableCell(withIdentifier: "secondcell", for: indexPath) as! SecondCartTableViewCell
        let eID = self.info2[indexPath.row].userEmailID
        celltwo.nameOfItemLabel.text = self.info2[indexPath.row].productName
        celltwo.descriptionOfItemLabel.text = self.info2[indexPath.row].productDescription
        
        return celltwo
    }
}
