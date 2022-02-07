//
//  WindowHelper.swift
//  NeoPortfolio
//
//  Created by Ali Merhie on 2/5/22.
//

import Foundation
import UIKit

final class WindowHelper {
    public var window: UIWindow
    static let shared = WindowHelper()
    
    private init() {
        window = AppDelegate.shared.window!
    }
}
