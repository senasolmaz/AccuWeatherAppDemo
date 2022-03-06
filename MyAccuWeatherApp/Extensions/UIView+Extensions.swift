//
//  UIView+Extensions.swift
//  MyAccuWeatherApp
//

import Foundation
import UIKit

extension UIView {
    
    func makeCornerRadius(radius: CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
}

extension UIViewController {
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func createLoadingView() {
        let child = SpinnerViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
    }
    
    func removeLoadingView() {
        if let foundView = view.viewWithTag(1) {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            foundView.removeFromSuperview()
//            }
        }
    }
}
