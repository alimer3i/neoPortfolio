//
//  ScreenLoader.swift
//  MVisa
//
//  Created by Ali Merhie on 5/4/20.
//  Copyright © 2020 Monty Mobile. All rights reserved.
//

import Foundation
import UIKit

protocol ScreenLoader {
    
    static func setRootNavigationController() -> Self
    
}

extension ScreenLoader where Self: Storyboarded & UIViewController {
    
    static func setRootNavigationController() -> Self{
        let nextViewController = Self.instantiate() //storyboard.instantiateViewController(withIdentifier: viewController.viewControllerIdentifier)
        
        let nav = UINavigationController(rootViewController: nextViewController)
        
        WindowHelper.shared.window.rootViewController = nav
        return nextViewController
    }
    
    static func pushVC(mainView: UIViewController, animated: Bool = true) -> Self{
        let nextViewController = Self.instantiate()
        mainView.navigationController?.pushViewController(nextViewController, animated: animated)
        return nextViewController
    }
    
    
        static func getVC() -> Self{
            let nextViewController = Self.instantiate()
            return nextViewController
    
        }
}

