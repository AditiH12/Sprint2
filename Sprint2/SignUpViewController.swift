//
//  SignUpViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/24/22.
//

import UIKit
import CoreData
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
                                                   

class SignUpViewController: UIViewController {          // SignUp class to register user begins.
    
    //Outlets created for all the textfields on the SignUp Page.
    
    @IBOutlet weak var UserNameTextField: UITextField!
    @IBOutlet weak var EmailForSignupPage: UITextField!
    @IBOutlet weak var MobileNoTextField: UITextField!
    @IBOutlet weak var PasswordForSignupPage: UITextField!
    @IBOutlet weak var ConfirmPassTextField: UITextField!
    @IBOutlet weak var SignupButton: UIButton!
    var regEmail = [String?]()                              //Array for storing emailId.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    static func getVC() -> SignUpViewController{
        let storyBoard = UIStoryboard(name:"Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        return vc
    }
    
    
    //Function to register user through Firebase.
    
    func signUpUserByFirebase(EmailForSignupPage: String, PasswordForSignupPage: String){
        Auth.auth().createUser(withEmail: EmailForSignupPage, password: PasswordForSignupPage, completion: {
            (result, error)-> Void in
            
            if let _error = error{
                print(_error.localizedDescription)
            }
            else{
                print("User Registered successfully.")
            }
        })
    }

    
    
    @IBAction func SignUpBtnClicked(_ sender: Any) {         //Functionality when SignUp button is clicked.
   
        let emailFirebase2: String = EmailForSignupPage.text!
        let passwordFirebase2: String = PasswordForSignupPage.text!
        //signUpUserByFirebase(EmailForSignupPage: emailFirebase2, PasswordForSignupPage: passwordFirebase2)
        
        let userDictionary = ["userName":UserNameTextField.text, "userEmailID":EmailForSignupPage.text, "userMobileNo":MobileNoTextField.text, "userPassword":PasswordForSignupPage.text]
        
        let providedName = UserNameTextField.text
        let providedEmail = EmailForSignupPage.text
        let providedMobileNo = MobileNoTextField.text
        let providePassword = PasswordForSignupPage.text
        
        
        _ = isValidName(nameString: providedName!)
        _ = isValidEmail(emailString: providedEmail!)
        _ = isValidPassword(passwordString: providePassword!)
        _ = isValidMobileNo(mobileString: providedMobileNo!)
        
    
                                                    
    func isValidName(nameString: String) -> Bool {                      //Function to check Name validation.
        var returnValue = true
        let nameRegEx = "^([a-zA-Z]{4,})"                               //Should be minimum 4 characters.
        do {
            let regex = try NSRegularExpression(pattern: nameRegEx)
            let nsString = nameString as NSString
            let results = regex.matches(in: nameString, range: NSRange(location: 0,length: nsString.length))
            
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

    
    func isValidEmail(emailString: String) -> Bool {                      //Function to check Email Validation.
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"  //Should be proper email format.
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
    
    
    func isValidMobileNo(mobileString: String) -> Bool {                //Function to check Mobile Number Validation.
        var returnValue = true
        let mobileRegEx = "^\\+(?:[0-9]?){6,14}[0-9]$"
        do {
            let regex = try NSRegularExpression(pattern: mobileRegEx)
            let nsString = mobileString as NSString
            let results = regex.matches(in: mobileString, range: NSRange(location: 0,length: nsString.length))
            
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
    

    
    func isValidPassword(passwordString: String) -> Bool {             //Function to check Password Validation.
        var returnValue = true
        //Password length 6 to 16
        //Atleast one alphabet
        //Atleast one special character in the password
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,16}"     //Rules for Password Validation.
        do {
            let regex = try NSRegularExpression(pattern: passwordRegEx)
            let nsString = passwordString as NSString
            let results = regex.matches(in: passwordString, range: NSRange(location: 0,length: nsString.length))
            
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

   
        func displayAlertMessage(messageToDisplay: String)               //Function to display Alert Message Box.
        {
            let alertController = UIAlertController(title: "Alert title",message: messageToDisplay, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default){
                (action:UIAlertAction!) in                          //Code in this block will trigger when OK button tapped.
                
                print("OK Buuton tapped");
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
            }
 
        
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
                
                func save(object: [String : String]){
                    let user = NSEntityDescription.insertNewObject(forEntityName: "Sprint2", into: context!) as! Sprint2
                    user.userName = object["userName"]
                    user.userEmailID = object["userEmailID"]
                    user.userMobileNo = object["userMobileNo"]
                    user.userPassword = object["userPassword"]
                    
                    do{
                        try context?.save()
                    }catch{
                        print("Data not Saved")
                    }
                }
                
            var user1 = [Sprint2]()
            let fetchEmpDetails = NSFetchRequest<NSManagedObject>(entityName: "Sprint2")
            
            do {
                user1 = try context?.fetch(fetchEmpDetails) as! [Sprint2]
            }catch{
                print("Cannot get data")
            }
         
        for email in user1{
            regEmail.append(email.userEmailID)
        }
        
        if regEmail.contains(EmailForSignupPage.text!){
            let alert = UIAlertController(title: "Alert", message: "Email already exists.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
            })
        }
        
        else if let name = self.UserNameTextField.text, let emailId = self.EmailForSignupPage.text, let num = self.MobileNoTextField.text, let pass = self.PasswordForSignupPage.text, let confirmPass = ConfirmPassTextField.text{
                
            if name.isEmpty{                                       //Condition for empty Name textfield
                    let alert = UIAlertController(title: "Alert", message: "Please enter Name", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"OK",style: .default, handler: nil))
                    present(alert, animated: true, completion: {
                        return
                    })
                }
            else if isValidName(nameString: name) == false{             //Condition to display invalid name
                    print("Name is not valid")
                    displayAlertMessage(messageToDisplay: "Name must contain atleast 4 alphabets.")
                }
           
            else if emailId.isEmpty{
                let alert = UIAlertController(title: "Alert", message: "Please enter Email ID", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style: .default, handler: nil))
                present(alert, animated: true, completion: {
                    return
                })
            }else if isValidEmail(emailString: emailId) == false{               //Condition to display invalid emailId
                print("Email ID is not valid")
                displayAlertMessage(messageToDisplay: "Email ID is not valid.Please enter valid Email ID.")
            }
            else if num.isEmpty{
                let alert = UIAlertController(title: "Alert", message: "Please enter Mobile Number", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style: .default, handler: nil))
                present(alert, animated: true, completion: {
                    return
                })
            }
            else if isValidMobileNo(mobileString: num) == false{            //Condition to display invalid mobile Number.
                print("Mobile Number is not valid")
                displayAlertMessage(messageToDisplay: "Mobile Number is not valid.Must contain country code with number.")
            }
            else if pass.isEmpty{
                let alert = UIAlertController(title: "Alert", message: "Please enter Password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style: .default, handler: nil))
                present(alert, animated: true, completion: {
                    return
                })
            }
            else if isValidPassword(passwordString: pass) == false{         //Condition to display invalid password
                print("Password is not valid.Please enter correct password.")
                displayAlertMessage(messageToDisplay: "Password is not valid.Please enter correct password.")
            }
            else if confirmPass != PasswordForSignupPage.text{
                let alert = UIAlertController(title: "Alert", message: "Password does not match.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style: .default, handler: nil))
                present(alert, animated: true, completion: {
                    return
                })
            }
            else if confirmPass.isEmpty{
                let alert = UIAlertController(title: "Alert", message: "Please Confirm Password.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK",style: .default, handler: nil))
                present(alert, animated: true, completion: {
                    return
                })
            }

           else{
               let emailId: String = EmailForSignupPage.text!
               let password: String = PasswordForSignupPage.text!
                save(object: userDictionary as! [String:String])
                //let itemlistVc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                //self.navigationController?.pushViewController(itemlistVc, animated: true)
               let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
               self.navigationController?.pushViewController(tabBarVC, animated: true)
               //self.navigationItem.setHidesBackButton(true, animated: true)            }
             //  signUpUserByFirebase(EmailForSignupPage: emailFirebase2, PasswordForSignupPage: passwordFirebase2)
               signUpUserByFirebase(EmailForSignupPage: emailFirebase2, PasswordForSignupPage: passwordFirebase2)           }
    }
    
}
}
