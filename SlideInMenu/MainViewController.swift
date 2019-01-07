//
//  MainViewController.swift
//  SlideInMenu
//
//  Created by Alvin on 7/1/19.
//  Copyright © 2019 Alvin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func menuTapped(_ sender: Any) {
        self.slideInMenuController()?.openLeft()
    }
}

public extension UIStoryboard {
    class func mainViewController() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainViewController")
    }
    
    class func mainNavigationController() -> UINavigationController {
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
    }
    
    class func menuViewController() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MenuViewController")
    }
}
