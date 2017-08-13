//
//  PHILogView.swift
//  PHILogViewer
//
//  Created by phi161 on 13/08/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import UIKit

enum ViewSize {
    case top
    case bottom
    case full
}

protocol PHILogViewDelegate: class {
    func logViewDidClose(_ logView: PHILogView)
    func logViewDidClear(_ logView: PHILogView)
    func logView(_ logView: PHILogView, didResize size: ViewSize)
}

class PHILogView: UIView {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var topHalfButton: UIButton!
    @IBOutlet weak var bottomHalfButton: UIButton!
    @IBOutlet weak var fullscreenButton: UIButton!
    
    weak var delegate: PHILogViewDelegate? = nil
    
    public static func loadFromNib() -> PHILogView {
        return Bundle.main.loadNibNamed("PHILogView", owner: self, options: nil)?.first as! PHILogView!
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        delegate?.logViewDidClose(self)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        delegate?.logViewDidClear(self)
    }
    
    @IBAction func resizeButtonTapped(_ sender: UIButton) {
        if sender == topHalfButton {
            delegate?.logView(self, didResize: .top)
        } else if sender == bottomHalfButton {
            delegate?.logView(self, didResize: .bottom)
        } else if sender == fullscreenButton {
            delegate?.logView(self, didResize: .full)
        }
    }
    
}
