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
    
    private static var logs: [String] = [] {
        didSet {
            view.textView.text = logs.joined(separator: "\n")
        }
    }

    public static func setup() {
        let tap = UITapGestureRecognizer(target: instance, action: #selector(windowTapped(_:)))
        tap.numberOfTouchesRequired = 3
        guard let window = UIApplication.shared.delegate?.window else { fatalError() }
        window?.addGestureRecognizer(tap)
    }

    public static func log(_ text: String) {
        logs.append("\(DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)) \(text)")
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
    
    func logView(_ logView: PHILogView, didResize size: ViewSize) {
        let screenBounds = UIScreen.main.bounds
        let quarterScreen = UIScreen.main.bounds.height/4
        switch size {
        case .top:
            PHILogger.view.frame = screenBounds.insetBy(dx: 0, dy: quarterScreen).offsetBy(dx: 0, dy: -quarterScreen)
        case .bottom:
            PHILogger.view.frame = screenBounds.insetBy(dx: 0, dy: quarterScreen).offsetBy(dx: 0, dy: quarterScreen)
        case .full:
            PHILogger.view.frame = UIScreen.main.bounds
        }
    }
}
