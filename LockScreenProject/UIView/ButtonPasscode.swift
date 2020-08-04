//
//  ButtonPasscode.swift
//  LockScreenProject
//
//  Created by Hajji Anwer on 8/3/20.
//  Copyright © 2020 spare.

import Foundation
import UIKit

@IBDesignable
class ButtonPasscode : UIButton {
    
    @IBInspectable
    open var tagButton: String = "1"
    
    @IBInspectable
    open var borderColor: UIColor = .white {
        didSet {
            setupButton()
        }
    }

    @IBInspectable
    open var borderRadius: CGFloat = 30 {
        didSet {
            setupButton()
        }
    }

    @IBInspectable
    open var highlightBackgroundColor: UIColor = .clear {
        didSet {
            setupButton()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        addTargetButton()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTargetButton()
    }

    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 60, height: 60)
    }

    private var defaultBackgroundColor: UIColor = .clear

    private func setupButton() {
        layer.borderWidth = 1
        layer.cornerRadius = borderRadius
        layer.borderColor = borderColor.cgColor
        if let backgroundColor = backgroundColor {
            defaultBackgroundColor = backgroundColor
        }
    }
    
    private func addTargetButton() {
        addTarget(self, action: #selector(ButtonPasscode.handleTouchDown), for: .touchDown)
        addTarget(self, action: #selector(ButtonPasscode.handleTouchUp), for: [.touchUpInside, .touchDragOutside, .touchCancel])
    }

    @objc func handleTouchDown() {
        animateBackgroundColor(highlightBackgroundColor)
    }

    @objc func handleTouchUp() {
        animateBackgroundColor(defaultBackgroundColor)
    }

    private func animateBackgroundColor(_ color: UIColor) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0.0,
            options: [.allowUserInteraction, .beginFromCurrentState],
            animations: {
                self.backgroundColor = color
            },
            completion: nil
        )
    }
 
}
