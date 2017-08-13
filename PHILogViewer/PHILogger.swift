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
    
    private static let view: PHILogView = {
        let logView = PHILogView.loadFromNib()
        logView.delegate = instance
        return logView
    }()

    public static func setup() {
        let tap = UITapGestureRecognizer(target: instance, action: #selector(windowTapped(_:)))
        tap.numberOfTouchesRequired = 3
        guard let window = UIApplication.shared.delegate?.window else { fatalError() }
        window?.addGestureRecognizer(tap)
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
}
