//
//  PHILogView.swift
//  PHILogViewer
//
//  Created by phi161 on 13/08/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import UIKit

class PHILogView: UIView {
    @IBOutlet weak var textView: UITextView!
    
    public static func loadFromNib() -> PHILogView {
        return Bundle.main.loadNibNamed("PHILogView", owner: self, options: nil)?.first as! PHILogView!
    }
}
