//
//  NotificationViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/27/22.
//

import UIKit
import FrameworkForNotification                     //importing custom Framework.

class NotificationViewController: UIViewController {

    
    @IBOutlet weak var getNotificationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true        // Hides the back button from the navigation bar.
    }
    
    @IBAction func getNotification(_ sender: Any) {
        
           let obj = NotificationClass()              // Creating object to access functions from custom Framework.
           obj.localNotification()                    //Accessing public function from Framework.
           
       }
   
    static func getVC() -> NotificationViewController{
            let storyBoard = UIStoryboard(name:"Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
            return vc
            }
    
}


