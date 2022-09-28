//
//  TabBarViewController.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/25/22.
//

import UIKit

class TabBarViewController: UITabBarController {        //Class for displaying Category and Cart tabs Begins.

    override func viewDidLoad() {
        super.viewDidLoad()

       // self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }

}

   /* @objc func didTapButton(){               //Create and present tab bar controllers.
        let tabBarVC = UITabBarController()
        let vc1 = CategoryViewController()
        let vc2 = CartViewController()
        tabBarVC.setViewControllers([vc1, vc2], animated: false)
        
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
*/

func didTapButton(){                               //Function to toggle between tabs.
    let vc1 = CategoryViewController()
    let vc2 = CartViewController()
    
    vc1.title = "Category"
    vc2.title = "Cart"
    
    let tabBarVC = UITabBarController()
   
    tabBarVC.setViewControllers([vc1, vc2], animated: false)
    guard let items = tabBarVC.tabBar.items else{
        return
    }
    let images = ["cart", "cart"]
    
    for x in 0..<items.count {
        items[x].image = UIImage(systemName: images[x])
    }
    
}


