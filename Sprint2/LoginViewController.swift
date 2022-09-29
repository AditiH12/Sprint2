//
//  LoginViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/23/22.
//

import UIKit
import LocalAuthentication
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailTextForLoginPage: UITextField!
    @IBOutlet weak var PasswordTextForLoginPage: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var GoToSignUpPageButton: UIButton!
    
    
    
    @IBOutlet weak var forgotPassBtnTapped: UIButton!
    
    var emailForgotPassword = " "
   // var regEmail = [String]()
    var regEmail = [String?]()
    var regPassword = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       authenticateUserByFaceTouchID()
    }
    
    // Function to authenticate user by FaceID.
    func authenticateUserByFaceTouchID(){
       let context = LAContext()
        var error: NSError?
        let reasonStr = "Identify yourself"
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonStr){
                [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    
                
                if success{
                    self?.showAlert(msgStr: "Authenticated successfully", title: "Success")
                    
                }else{
                  
                }
                }
              }
            }
            else{
                self.showAlert(msgStr: "No biometric authentication available", title: "Error")
            }
        }
    
    func showAlert (msgStr : String, title : String){
        let alert = UIAlertController(title: title,message: msgStr, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMessageWithErrorCode(errorcode: Int) -> String{
        var msgStr = ""
        switch errorcode{
        case LAError.appCancel.rawValue:
            msgStr = "Authentication was cancelled by application."
        
    case LAError.authenticationFailed.rawValue:
        msgStr = "Unable to authenticate the user."
        
    default :
        msgStr = "common error"
    }
    return  msgStr
}
   
    //Testing part.
    static func getVC() -> LoginViewController{
            let storyBoard = UIStoryboard(name:"Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            return vc
            }
    
    func loginUserByFirebase(EmailTextForLoginPage: String, PasswordTextForLoginPage: String){
        Auth.auth().signIn(withEmail: EmailTextForLoginPage, password: PasswordTextForLoginPage, completion: {
            (result, error)-> Void in
            
            if let _error = error{
                print(_error.localizedDescription)
                let alert = UIAlertController(title: "Alert", message: "Wrong credentials.Try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style: .default, handler: nil))
                self.present(alert, animated: true, completion: {
                    return
                })
            }
            else{
                print("Logged in")
                let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                self.navigationController?.pushViewController(tabBarVC, animated: true)
                self.navigationItem.setHidesBackButton(true, animated: true)
            }
        })
    }
    

    @IBAction func LoginButtonClicked(_ sender: Any) {
        
let emailFirebase1: String = EmailTextForLoginPage.text!     //Saving email ID that user enters into emailFirebase variable.
        
let passwordFirebase1: String = PasswordTextForLoginPage.text!   //Saving password that user enters into passwordFirebase variable.
        
        loginUserByFirebase(EmailTextForLoginPage: emailFirebase1, PasswordTextForLoginPage: passwordFirebase1)
        //Calling the function for Firebase authentication.
        
        
        let providedEmail = EmailTextForLoginPage.text
        
        let isEmailValid = isValidEmail(emailString: providedEmail!)
        
        if let email = self.EmailTextForLoginPage.text {
            if isEmailValid                               //Condition to check if email is valid.
            {
                print("Email ID is valid")
            }
            else if email.isEmpty{                        //Condition to check if email textfield is empty.
                let alert = UIAlertController(title: "Alert", message: "Please enter Email ID", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style: .default, handler: nil))
                present(alert, animated: true, completion: {
                    return
                })
            }else {                                       //Condition to check if email is invalid.
                print("Email ID is not valid")
                let alert = UIAlertController(title: "Alert", message: "Email ID not valid.Please enter valid Email ID.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style: .default, handler: nil))
                present(alert, animated: true, completion: {
                    return
                })
            }
        }
        
        if let pass = self.PasswordTextForLoginPage.text{                    //Check if password field is empty.
            
            if pass.isEmpty{
            let alert = UIAlertController(title: "Alert", message: "Please enter Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK",style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
            })
        }
      
        }
        
        func isValidEmail(emailString: String) -> Bool {           //Function to check email validation.
            var returnValue = true
            let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"    //Email validation condition
            do {
                let regex = try NSRegularExpression(pattern: emailRegEx)
                let nsString = emailString as NSString
                let results = regex.matches(in: emailString, range: NSRange(location: 0,length: nsString.length))
                
                if results.count == 0
                {
                    returnValue = false
                }
            }catch let error as NSError {
                print("Invalid Regex: \(error.localizedDescription)")
                returnValue = false
            }
            return returnValue
        }

        
    

        // Coredata Part.
        
       let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
       var details = [Sprint2]()
        let fetchDetails = NSFetchRequest<NSManagedObject>(entityName: "Sprint2")
        do{
            details = try context?.fetch(fetchDetails) as! [Sprint2]
            print(details)
        }catch{
            print("Cannot get data")
        }
        
        for email in details{
            regEmail.append(email.userEmailID)
            print(regEmail)
        }
        if !(regEmail.contains(EmailTextForLoginPage.text!)){
            let emailId: String = EmailTextForLoginPage.text!
            let pass: String = PasswordTextForLoginPage.text!
            loginUserByFirebase(EmailTextForLoginPage: emailId, PasswordTextForLoginPage: pass)
        }
        else{
            let emailId: String = EmailTextForLoginPage.text!
            let pass: String = PasswordTextForLoginPage.text!
            loginUserByFirebase(EmailTextForLoginPage: emailId, PasswordTextForLoginPage: pass)
        }
    }
   
    @IBAction func ForgotPassBtnClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "forgotpass", sender: nil)
    }
    
   
}
    
    
    

