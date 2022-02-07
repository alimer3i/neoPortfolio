//
//  BaseVM.swift
//  VirtualNumber
//
//  Created by Ali Merhie on 9/1/21.
//

import Foundation

class BaseVM {
    
    var showLoader: ((String)->())?
    var hideLoader: (()->())?
    var startSkeletonAnimation: (()->())?
    var hideSkeletonAnimation: (()->())?
    var showAlert: ((String, String)->())?
    var showConfirmAlert: ((String, String, String, String, @escaping (Bool) -> ())->())?
    
    required init() {
        print("BASEVM")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("Memory to be released soon \(self)")
    }
}
