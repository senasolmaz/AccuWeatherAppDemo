//
//  UIView+Extensions.swift
//  MyAccuWeatherApp
//

import Foundation
import UIKit

extension UIView {
    
    static let loadingViewTag = 10
    
    func showLoading(style: UIActivityIndicatorView.Style = .medium) {
        var loading = viewWithTag(UIImageView.loadingViewTag) as? UIActivityIndicatorView
        if loading == nil {
            loading = UIActivityIndicatorView(style: style)
        }
        
        loading?.translatesAutoresizingMaskIntoConstraints = false
        loading!.startAnimating()
        loading!.hidesWhenStopped = true
        loading?.tag = UIView.loadingViewTag
        addSubview(loading!)
        loading?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func stopLoading() {
        let loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
    
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
    
    func addLastSearchView(value: String, clickEvent: SearchHistoryButtonClickEvent) -> UIButton {
         
        let wordButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        //only ios 15
        if #available(iOS 15, *) {
        var configuration = UIButton.Configuration.filled()
        configuration.title = value
        configuration.baseBackgroundColor = .systemGray4
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5)
        wordButton.configuration = configuration
        }else {
            wordButton.setTitle(value, for: .normal)
        }
      
       wordButton.addTarget(self, action: #selector(clickEvent.onClickHistoryButton), for: .touchUpInside)
        
        return wordButton
         
     }
}
