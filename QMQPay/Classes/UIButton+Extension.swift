//
//  UIButton+Extension.swift
//  QatarPaySDK
//
//  Created by Hussam Elsadany on 28/09/2021.
//

import UIKit

extension UIButton {
    var activityIndicatorTag: Int {
        return 1
    }

    func startLoading(style: UIActivityIndicatorView.Style = .white) {
        setTitle("", for: .disabled)
        isEnabled = false
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: style)
        activityIndicator.color = self.titleLabel?.textColor
        activityIndicator.tag = activityIndicatorTag
        addSubview(activityIndicator)
        pinItemToEdges(item: activityIndicator)
        activityIndicator.startAnimating()
        UIView.performWithoutAnimation { [weak self] in
            self?.layoutIfNeeded()
        }
    }

    func stopLoading() {
        isEnabled = true
        if let activityIndicator = viewWithTag(activityIndicatorTag) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }

        UIView.performWithoutAnimation { [weak self] in
            self?.layoutIfNeeded()
        }
    }
}

