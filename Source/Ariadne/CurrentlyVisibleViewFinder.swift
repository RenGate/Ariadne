//
//  CurrentlyVisibleViewFinder.swift
//  Ariadne
//
//  Created by Denys Telezhkin on 10/17/18.
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
#if canImport(UIKit)
import UIKit

#if os(iOS) || os(tvOS)
extension UIWindow: RootViewProvider {}

/// Class, capable of finding currently visible view, using recursive search through UIViewController, UINavigationController and UITabBarController APIs.
open class CurrentlyVisibleViewFinder: ViewFinder {

    /// Provider of root view in hierarchy
    public let rootViewProvider: RootViewProvider?

    /// Creates `CurrentlyVisibleViewFinder`.
    ///
    /// - Parameter rootViewProvider: provider of root view in hierarchy
    public init(rootViewProvider: RootViewProvider?) {
        self.rootViewProvider = rootViewProvider
    }

    /// Searches view hierarhcy for currently visible view. If no visible view was found, root view controller from `rootViewProvider` is returned.
    ///
    /// - Parameter view: view controller to start search from. When nil is passed as an argument, search starts from rootViewController. Defaults to nil.
    /// - Returns: currently visible view or rootViewController if none was found.
    open func currentlyVisibleView(startingFrom view: ViewController? = nil) -> ViewController? {
        return findCurrentlyVisibleView(startingFrom: view ?? rootViewProvider?.rootViewController)
    }

    /// Recursively searches view hierarchy for currently visible view.
    ///
    /// - Parameter view: view to start search from
    /// - Returns: currently visible view.
    open func findCurrentlyVisibleView(startingFrom view: ViewController?) -> ViewController? {
        guard let view = view else { return nil }

        var visibleView: ViewController?
        switch view {
        case let tabBar as UITabBarController:
            visibleView = findCurrentlyVisibleView(startingFrom: tabBar.selectedViewController ?? tabBar.presentedViewController) ?? tabBar
        case let navigation as UINavigationController:
            visibleView = findCurrentlyVisibleView(startingFrom: navigation.visibleViewController) ?? navigation
        default:
            visibleView = findCurrentlyVisibleView(startingFrom: view.presentedViewController) ?? view
        }
        return visibleView ?? view
    }
}

#endif

#endif
