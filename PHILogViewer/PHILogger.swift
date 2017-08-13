//
//  PHILogger.swift
//  PHILogViewer
//
//  Created by phi161 on 13/08/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import UIKit

class PHILogger: NSObject {

    private static let instance = PHILogger()
    
    static let view: PHILogView = {
        let logView = PHILogView.loadFromNib()
        return logView
    }()
}
