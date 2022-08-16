//
//  UIButton + Extensions.swift
//  GTMBarCodeScannerDemo
//
//  Created by Venkata Ajay Sai (Paras) on 16/08/22.
//

import UIKit
extension UIButton {
    
    var isShow: Bool {
        get {
            return !isHidden
        }
        set {
            isHidden = !newValue
        }
    }
}
