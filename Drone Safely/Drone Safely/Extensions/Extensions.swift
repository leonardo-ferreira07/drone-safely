//
//  Extensions.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import SafariServices

extension UIViewController: SFSafariViewControllerDelegate {
    
    public func presentWebPageInSafari(withURLString URLString: String) {
        
        if let url = URL(string: URLString), UIApplication.shared.canOpenURL(url) {
//            let vc = SFSafariViewController(url: url)
//            vc.delegate = self
//            self.present(vc, animated: true)
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            showAlert("Opening link error", message: "There was an error trying to open the web link.")
        }
    }
    
    func showAlert(_ title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: handler))
        present(alert, animated: true, completion: nil)
    }
    
    func presentActivityIndicator(_ present: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = present
        }
    }
    
}


extension UIView {
    func startLoadingAnimation() {
        stopLoadingAnimation()
        
        DispatchQueue.main.async {
            let loadingView = LoadingViewPresenter.newInstance()
            loadingView.frame = UIScreen.main.bounds
            UIApplication.shared.keyWindow?.addSubview(loadingView)
        }
    }
    
    func stopLoadingAnimation() {
        DispatchQueue.main.async {
            if let subviews = UIApplication.shared.keyWindow?.subviews {
                for subview in subviews {
                    if let subview = subview as? LoadingViewPresenter {
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
}
