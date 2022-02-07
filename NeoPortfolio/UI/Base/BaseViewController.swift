//
//  BaseViewController.swift
//  VirtualNumber
//
//  Created by Ali Merhie on 8/30/21.
//

import Foundation
import UIKit
import MBProgressHUD

class BaseViewController<Element: BaseVM>: UIViewController, Storyboarded, ScreenLoader {
    
    class var pageStoryBoard: AppStoryboard {
        get {
            return .Main
        }
    }
    internal var viewModel = Element()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)



    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .primaryBlue
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.3
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
    }
    
    internal func bindToViewModel() {
        viewModel.showLoader = { [weak self] message in
            let hud = MBProgressHUD.showAdded(to: (self?.view) ?? UIView() , animated: true)
            hud.label.text = message
            hud.isUserInteractionEnabled = true
        }
        
        viewModel.hideLoader = { [weak self] in
            MBProgressHUD.hide(for: (self?.view) ?? UIView() , animated: true)
        }
        
//        viewModel.showAlert = { [weak self] title, message in
//            self?.showAlert(title: title, message: message)
//        }
        viewModel.showConfirmAlert = { [weak self] title, message, confirmtext, cancelText, completion in
            self?.displayConfirmAlert(title: title, message: message, confirmText: confirmtext, cancelText: cancelText, completion: { isConfirm in
                 completion(isConfirm)
            })
        }
    }
    internal func displayAlert(title: String, message: String, cancelText: String) {
        //        let vc = UIApplication.getTopViewController()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: cancelText, style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    internal func displayConfirmAlert(title: String, message: String, confirmText: String, cancelText: String, completion: @escaping (Bool) -> () ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: cancelText, style: .destructive,  handler: { (action) in completion(false) })
        let confirm = UIAlertAction(title: confirmText, style: .default, handler: { (action) in completion(true) })
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        self.present(alert, animated: true, completion: nil)
    }

    @objc func willEnterForeground() {
        print("will enter foreground \(self)")
    }

    @objc func keyboardWillAppear() {
        print("keyboard will appear")
    }
    
    @objc func keyboardWillDisappear() {
        print("keyboard will disappear")
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("Memory to be released soon \(self)")
    }
    
}

