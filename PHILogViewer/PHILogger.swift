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

    fileprivate static let view: PHILogView = {
        let logView = PHILogView.loadFromNib()
        logView.delegate = instance
        return logView
    }()

    fileprivate static var logs: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                view.textView.text = logs.joined(separator: "\n")
            }
        }
    }

    public static func setup() {
        let tap = UITapGestureRecognizer(target: instance, action: #selector(windowTapped(_:)))
        tap.numberOfTouchesRequired = 3
        guard let window = UIApplication.shared.delegate?.window else { fatalError() }
        window?.addGestureRecognizer(tap)
    }

    public static func log(_ text: String) {
        //TODO: Using append should be faster but then we need to automatically scroll the textview to the bottom which looked buggy when using scrollRangeToVisible
        logs.insert("\(DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)) \(text)", at: 0)
    }

    @objc private func windowTapped(_ tap: UITapGestureRecognizer) {
        UIApplication.shared.keyWindow?.addSubview(PHILogger.view)
        PHILogger.view.frame = UIScreen.main.bounds
    }

}

extension PHILogger: PHILogViewDelegate {
    func logViewDidClose(_ logView: PHILogView) {
        logView.removeFromSuperview()
    }

    func logViewDidClear(_ logView: PHILogView) {
        PHILogger.logs.removeAll()
    }

    func logView(_ logView: PHILogView, didResize size: ViewSize) {
        let screenBounds = UIScreen.main.bounds
        let quarterScreen = UIScreen.main.bounds.height/4
        switch size {
        case .topHalf:
            PHILogger.view.frame = screenBounds.insetBy(dx: 0, dy: quarterScreen).offsetBy(dx: 0, dy: -quarterScreen)
        case .bottomHalf:
            PHILogger.view.frame = screenBounds.insetBy(dx: 0, dy: quarterScreen).offsetBy(dx: 0, dy: quarterScreen)
        case .full:
            PHILogger.view.frame = UIScreen.main.bounds
        }
    }
}
