//
//  Utilities.swift
//  Twiter
//
//  Created by aymen braham on 04/02/2021.
//

import Foundation
import UIKit

class Utilities {
    
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
      let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let iv = UIImageView()
        iv.image = image
        view.addSubview(iv)
        iv.anchor( left: view.leftAnchor, bottom: view.bottomAnchor, paddingBottom: 16)
        iv.setDimensions(width: 24, height: 24)
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,  paddingBottom: 16)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .white
        view.addSubview(separatorView)
        separatorView.anchor( left: iv.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,  height: 1)
        return view
    }
    
    func textField(withPlaceHolder placeHolder: String, isSecure: Bool) -> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.isSecureTextEntry = isSecure
        tf.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tf
    }
    
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes:[ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSMutableAttributedString(string: secondPart, attributes:[ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
}
