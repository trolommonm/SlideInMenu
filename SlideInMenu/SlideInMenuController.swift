//
//  SlideInMenuController.swift
//  SlideInMenu
//
//  Created by Alvin Tan De Jun on 6/1/19.
//  Copyright © 2019 Alvin. All rights reserved.
//

import UIKit

struct SlideInMenuOptions {
    static var leftViewWidth: CGFloat = 270.0
    static var animationDuration: Double = 0.4
    static var shadowRadius: CGFloat = 0.0
    static var shadowOpacity: CGFloat = 0.0
    static var shadowOffset: CGSize = CGSize.zero
}

class SlideInMenuController: UIViewController {
    
    var mainViewController: UIViewController!
    var mainViewContainer: UIView!
    var leftViewController: UIViewController!
    var leftViewContainer: UIView!
    
    convenience init(mainViewController: UIViewController, leftViewController: UIViewController) {
        self.init()
        self.mainViewController = mainViewController
        self.leftViewController = leftViewController
        initView()
    }
    
    func initView() {
        
        // set up mainViewContainer
        mainViewContainer = UIView(frame: view.bounds)
        mainViewContainer.backgroundColor = .clear
        mainViewContainer.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.insertSubview(mainViewContainer, at: 0)
        
        // set up leftViewContainer
        var leftFrame = view.bounds
        leftFrame.size.width = SlideInMenuOptions.leftViewWidth
        leftFrame.origin.x =  -SlideInMenuOptions.leftViewWidth
        leftFrame.origin.y = CGPoint.zero.y
        leftViewContainer = UIView(frame: leftFrame)
        leftViewContainer.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.insertSubview(leftViewContainer, at: 1)
        
    }
    
    override func viewWillLayoutSubviews() {
        setUpViewControllers(targetView: mainViewContainer, targetViewController: mainViewController)
        setUpViewControllers(targetView: leftViewContainer, targetViewController: leftViewController)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return mainViewController.preferredStatusBarStyle
    }
    
    func setUpViewControllers(targetView: UIView, targetViewController: UIViewController) {
        targetViewController.view.frame = targetView.bounds
        addChild(targetViewController)
        targetView.addSubview(targetViewController.view)
        targetViewController.didMove(toParent: self)
    }
    
    override func openLeft() {
        let xFinalOrigin: CGFloat = CGPoint.zero.x
        var frame = leftViewContainer.frame
        frame.origin.x = xFinalOrigin
        
        leftViewController.beginAppearanceTransition(true, animated: true)
        
        addShadowToView(leftViewContainer)
        
        UIView.animate(withDuration: SlideInMenuOptions.animationDuration, animations: { [weak self] in
            if let self = self {
                self.leftViewContainer.frame = frame
            }
        }, completion: { [weak self](Bool) -> Void in
            if let self = self {
                self.disableMainContainerInteraction()
                self.leftViewController.endAppearanceTransition()
            }
        })
    }
    
    override func closeLeft() {
        let xFinalOrigin: CGFloat = -SlideInMenuOptions.leftViewWidth
        var frame = leftViewContainer.frame
        frame.origin.x = xFinalOrigin
        
        leftViewController.beginAppearanceTransition(true, animated: true)
        
        UIView.animate(withDuration: SlideInMenuOptions.animationDuration, animations: { [weak self] in
            if let self = self {
                self.leftViewContainer.frame = frame
            }
        }, completion: { [weak self](Bool) -> Void in
            if let self = self {
                self.removeShadowFromView(self.leftViewContainer)
                self.enableMainContainerInteraction()
                self.leftViewController.endAppearanceTransition()
            }
        })
    }
    
    func disableMainContainerInteraction() {
        mainViewContainer.isUserInteractionEnabled = false
    }
    
    func enableMainContainerInteraction() {
        mainViewContainer.isUserInteractionEnabled = true
    }
    
    func addShadowToView(_ targetViewContainer: UIView) {
        targetViewContainer.layer.masksToBounds = false
        targetViewContainer.layer.shadowOffset = SlideInMenuOptions.shadowOffset
        targetViewContainer.layer.shadowOpacity = Float(SlideInMenuOptions.shadowOpacity)
        targetViewContainer.layer.shadowRadius = SlideInMenuOptions.shadowRadius
        targetViewContainer.layer.shadowPath = UIBezierPath(rect: targetViewContainer.bounds).cgPath
    }
    
    func removeShadowFromView(_ targetViewContainer: UIView) {
        targetViewContainer.layer.masksToBounds = true
    }
    
}

extension UIViewController {
    func slideInMenuController() -> SlideInMenuController? {
        var viewController: UIViewController? = self
        while viewController != nil {
            if viewController is SlideInMenuController {
                return viewController as? SlideInMenuController
            }
            viewController = viewController?.parent
        }
        return nil
    }
    
    @objc func openLeft() {
        slideInMenuController()?.openLeft()
    }
    
    @objc func closeLeft() {
        slideInMenuController()?.closeLeft()
    }
}
