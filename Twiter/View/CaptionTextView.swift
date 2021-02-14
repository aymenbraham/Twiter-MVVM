//
//  CaptionTextView.swift
//  Twiter
//
//  Created by aymen braham on 14/02/2021.
//

import UIKit

class CaptionTextView: UITextView {

    // MARK: - Properties
    
    let placeHolderLabel: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "What's happening?"
        return label
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .white
        isScrollEnabled = false
        font = UIFont.systemFont(ofSize: 16)
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        addSubview(placeHolderLabel)
        placeHolderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 4)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextLabel), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc
    func handleTextLabel() {
        placeHolderLabel.isHidden = !text.isEmpty
    }
    
    
}
