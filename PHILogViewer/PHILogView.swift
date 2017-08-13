//
//  PHILogView.swift
//  PHILogViewer
//
//  Created by phi161 on 13/08/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import UIKit

protocol PHILogViewDelegate: class {
    func logViewDidClose(_ logView: PHILogView)
}

class PHILogView: UIView {
    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: PHILogViewDelegate? = nil
    
    public static func loadFromNib() -> PHILogView {
        return Bundle.main.loadNibNamed("PHILogView", owner: self, options: nil)?.first as! PHILogView!
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        delegate?.logViewDidClose(self)
    }
    
}
