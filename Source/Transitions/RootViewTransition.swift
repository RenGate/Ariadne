//
//  RootViewTransition.swift
//  Ariadne
//
//  Created by Denys Telezhkin on 10/18/18.
//  Copyright © 2018 Denys Telezhkin. All rights reserved.
//

import Foundation

#if canImport(UIKit)
import UIKit

open class RootViewTransition: ViewTransition {
    public var transitionType: TransitionType = .show
    public var viewFinder: ViewFinder? = nil

    public let window: UIWindow
    
    open var duration: TimeInterval = 0.3
    open var animationOptions = UIView.AnimationOptions.transitionCrossDissolve
    open var isAnimated : Bool
    
    public init(window: UIWindow, isAnimated: Bool = true) {
        self.window = window
        self.isAnimated = isAnimated
    }
    
    open func perform(with view: View, on visibleView: View?, completion: ((Bool) -> ())?) {
        if isAnimated {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            UIView.transition(with: window, duration: duration,
                              options: animationOptions,
                              animations: {
                self.window.rootViewController = view
            }, completion: { state in
                UIView.setAnimationsEnabled(oldState)
                completion?(state)
            })
        }
        else {
            window.rootViewController = view
            completion?(true)
        }
    }
}

#endif
