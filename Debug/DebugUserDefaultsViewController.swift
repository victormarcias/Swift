//
//  DebugUserDefaultsViewController.swift
//  VMApp
//
//  Created by Victor on 2018-08-29.
//  Copyright © 2018 Victor Marcias. All rights reserved.
//

import UIKit

final class DebugUserDefaultsViewController: DebugOptionsViewController {
    
    override func setup() {
        navigationItem.title = "User Defaults Viewer"
        tableView.estimatedRowHeight = 50
        
        var itemList = [UserDefaultItem]()
        
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            if key.hasPrefix("debug.myApp") || key.hasPrefix("com.myApp") {
                itemList.append(UserDefaultItem(key: key, value: value))
            }
        }
        itemList.sort { $0.key ?? "" < $1.key ?? "" }
        
        options = [itemList]
    }
}

// MARK: - DebugUserDefaultOption

private final class UserDefaultItem: DebugOption {
    var key: String?
    var value: Any?
    
    required convenience init(key: String?, value: Any?) {
        self.init(type: .text)
        
        self.key = key
        self.value = value
        self.title = key
        self.subtitle = ""
        
        for (index, stringValue) in arrayOfValues.enumerated() {
            let isLast = (index == arrayOfValues.count - 1)
            subtitle = "\(subtitle!)\(stringValue)" + (isLast ? "" : "\n")
        }
    }
    
    var arrayOfValues: [String] {
        if let arr = value as? [Any] {
            return arr.map({ value in
                return (value as AnyObject).description
            })
        }
        return [self.string ?? ""]
    }
    
    private var string: String? {
        return "\(value!)"
    }
}
