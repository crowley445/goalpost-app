//
//  UIViewControllerExt.swift
//  goalpost-app
//
//  Created by Brian  Crowley on 12/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentDetail (_ viewControllerToPresent: UIViewController) {
        let transition = getTransition(duration: 0.3, type: kCATransitionPush, subtype: kCATransitionFromRight)
        view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }

    func presentSecondaryDetail (_ viewControllerToPresent: UIViewController) {
        let transition = getTransition(duration: 0.3, type: kCATransitionPush, subtype: kCATransitionFromRight)
        guard let presentedViewController = presentedViewController else { return }
        
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
    }
    
    func dismissDetail () {
        let transition = getTransition(duration: 0.3, type: kCATransitionPush, subtype: kCATransitionFromLeft)
        view.window?.layer.add(transition, forKey: kCATransition)

        dismiss(animated: false, completion: nil)
    }
    
    func getTransition(duration: Double, type: String, subtype: String ) -> CATransition {
        
        let transition = CATransition()
        transition.duration = duration
        transition.type = type
        transition.subtype = subtype
        
        return transition
    }
    
    func getButtonForAccessoryView(withTitle title: String) -> UIButton {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        btn.backgroundColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        return btn
    }
}
