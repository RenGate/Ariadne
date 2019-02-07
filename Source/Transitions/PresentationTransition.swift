//
//  PresentationTransition.swift
//  Ariadne
//
//  Created by Denys Telezhkin on 10/18/18.
//  Copyright © 2018 Denys Telezhkin. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

open class BaseAnimatedTransition {
    open var isAnimated: Bool
    public let viewFinder : ViewFinder?
    public init(finder: ViewFinder? = nil, isAnimated: Bool = true) {
        viewFinder = finder
        self.isAnimated = isAnimated
    }
}

#if canImport(UIKit)
import UIKit

#if os(iOS) || os(tvOS)

open class PresentationTransition : BaseAnimatedTransition, ViewTransition {
    public let transitionType: TransitionType = .show
    
    public func perform(with view: View, on visibleView: View?, completion: ((Bool) -> ())?) {
        guard let visibleView = visibleView else { completion?(false); return }
        visibleView.present(view, animated: isAnimated) {
            completion?(true)
        }
    }
}

open class DismissTransition: BaseAnimatedTransition, ViewTransition {
    public let transitionType: TransitionType = .hide
    
    public func perform(with view: View, on visibleView: View?, completion: ((Bool) -> ())?) {
        view.dismiss(animated: isAnimated) {
            completion?(true)
        }
    }
}

#endif

#endif
