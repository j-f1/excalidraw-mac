//
//  ProgressBar.swift
//  Excalidraw
//
//  Created by Jed Fox on 3/25/20.
//  Copyright © 2020 Jed Fox. All rights reserved.
//

import Cocoa

@IBDesignable
class ProgressBar : NSView {

    @IBInspectable @objc var progress: CGFloat = 0.5
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        progress = coder.decodeObject(forKey: "progress") as? CGFloat ?? 0.5
    }
    override func encode(with coder: NSCoder) {
        super.encode(with: coder)
        coder.encode(progress, forKey: "progress")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        let leftColor = (window?.isKeyWindow ?? false) ? NSColor.systemBlue : NSColor.systemGray
        let gradient = NSGradient(colorsAndLocations:
            (leftColor, 0),
            (leftColor, progress),
            (.clear, progress),
            (.clear, 1)
        )
        gradient?.draw(in: bounds, angle: 0)
    }

    // MARK: - Mark dirty
    override func viewDidMoveToWindow() {
        if self.window == nil {
            NotificationCenter.default.removeObserver(self)
        } else {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(forceUpdate),
                name: NSWindow.didResignKeyNotification,
                object: window
            )
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(forceUpdate),
                name: NSWindow.didBecomeKeyNotification,
                object: window
            )
        }
    }
    @objc func forceUpdate() {
        self.needsDisplay = true
    }
}
