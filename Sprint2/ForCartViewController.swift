//
//  ForCartViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/28/22.
//

import UIKit

class ForCartViewController: UIViewController {

    
    
    @IBOutlet weak var mycartTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mycartTable.delegate = self
        mycartTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    

   

}

extension ForCartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hi")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mycartTable.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        return cell
    }
}
