//
//  TabBarViewController.swift
//  MapsClone
//
//  Created by Abdurrahman Gazi Yavuz on 10/18/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let exploreVC   = UINavigationController(rootViewController: ExploreViewController())
//        let savedVC     = UINavigationController(rootViewController: SavedViewController())
        
//        exploreVC.title = "Explore"
//        savedVC.title   = "Saved"
        
//        exploreVC.tabBarItem.image          = UIImage(systemName: "location.circle")
//        exploreVC.tabBarItem.selectedImage  = UIImage(systemName: "location.circle.fill")
        
//        savedVC.tabBarItem.image            = UIImage(systemName: "book")
//        savedVC.tabBarItem.selectedImage    = UIImage(systemName: "book.fill")
        
//        tabBar.tintColor                    = .clear
//        tabBar.barTintColor                 = .clear
//        tabBar.backgroundColor              = .clear
        
        
        setViewControllers([exploreVC], animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
