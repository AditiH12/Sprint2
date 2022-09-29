//
//  ForgotPasswordNewViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/28/22.
//

import UIKit
import Firebase
import LocalAuthentication
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class ForgotPasswordNewViewController: UIViewController {

    
    
   // @IBOutlet weak var emailTextForgotPass: UITextField!
    
    @IBOutlet weak var SendBtn: UIButton!
    
    @IBOutlet weak var emailTextForgotpass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ForgotPassBtnClicked(_ sender: Any) {
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: emailTextForgotpass.text!) {
            (error) in
         //   let alert = Service.createAlertController(title: "hurray", message: "Password reset email sent to your email Id.")
          //  self.present(alert, animated: true, completion: nil)
        }
    }
}
