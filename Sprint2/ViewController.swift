//
//  ViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/21/22.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var launchLabel: UILabel!       //Outlet for the Launch Label.
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        launchLabel.text = ""
        let titletext = "Launch You App"          // Title of the label.
        var charIndex = 0.0
        
        for letter in titletext{                  // For parsing through the Label text.
            
            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) {
                (timer) in
                self.launchLabel.text?.append(letter)      //Appending letter by letter.
            }
            charIndex += 1
        }
        
    }



    
}

