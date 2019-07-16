//
//  PHILogView.swift
//  PHILogViewer
//
//  Created by phi161 on 13/08/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import UIKit

enum ViewSize {
    case topHalf
    case bottomHalf
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
    @IBOutlet weak var slider: UISlider!

    weak var delegate: PHILogViewDelegate?

    public static func loadFromNib() -> PHILogView {
        guard let logView = Bundle.main.loadNibNamed("PHILogView", owner: self, options: nil)?.first as? PHILogView else {
            fatalError("Unable to load PHILogView from nib")
        }
        return logView
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        alpha = CGFloat(sender.value)
    }

    @IBAction func sliderTouchedUp(_ sender: UISlider) {
        if sender.value < 0.1 {
            sender.value = 0.1
            alpha = 0.1
        }
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        delegate?.logViewDidClose(self)
    }

    @IBAction func clearButtonTapped(_ sender: Any) {
        delegate?.logViewDidClear(self)
    }

    @IBAction func resizeButtonTapped(_ sender: UIButton) {
        if sender == topHalfButton {
            delegate?.logView(self, didResize: .topHalf)
        } else if sender == bottomHalfButton {
            delegate?.logView(self, didResize: .bottomHalf)
        } else if sender == fullscreenButton {
            delegate?.logView(self, didResize: .full)
        }
    }

}
