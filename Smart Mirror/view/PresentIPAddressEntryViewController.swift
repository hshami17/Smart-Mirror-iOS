//
//  EntryAPIView.swift
//  Smart Mirror
//
//  Created by Diego Bustamante on 7/14/19.
//  Copyright © 2019 Hasan Shami. All rights reserved.
//

import UIKit

class PresentIPAddressEntryViewController: UIViewController {
    
    var ipAddressDelegate : IPAddressDelegate?
    
    var addAPIButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        button.backgroundColor = .white
        let attributedText = NSMutableAttributedString(string: "Connect", attributes: [NSAttributedString.Key.foregroundColor:UIColor.black])
        button.setAttributedTitle(attributedText, for: .normal)
        return button
    }()
    
    var entryField : UITextField = {
        let textfield = UITextField()
        textfield.textAlignment = .left
        textfield.textColor = .white
        textfield.keyboardType = UIKeyboardType.decimalPad
        textfield.keyboardAppearance = UIKeyboardAppearance.dark
        textfield.font = UIFont.systemFont(ofSize: 24, weight: .ultraLight)
        let attributedTextPlaceholder = NSMutableAttributedString(string: "Please enter an IP Address.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24, weight: .ultraLight), NSAttributedString.Key.foregroundColor : UIColor.gray])
        textfield.attributedPlaceholder = attributedTextPlaceholder
        textfield.clearButtonMode = .whileEditing
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavBar()
        setupKeyboardDismissal()
    }
}

// MARK: UI/UX Functions
extension PresentIPAddressEntryViewController {
    func setupUI() {
        view.backgroundColor = .black
        let stackView = UIStackView(arrangedSubviews: [UIView(), entryField,addAPIButton])
        stackView.alpha = 0
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchorCenter(centerXAnchor: view.centerXAnchor, centerYAnchor: view.centerYAnchor, centerXpadding: 0, centerYpadding: 0)
        
        let width = view.frame.width-40
        entryField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addAPIButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        entryField.widthAnchor.constraint(equalToConstant: width).isActive = true
        addAPIButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        stackView.fadeIn(0.3, delay: 0.6) { (done) in
            print("Done")
        }
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .radicalRed
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.title = "Smart Mirror"
    }
    
    
    @objc func handleSave() {
        print("Add")
        guard let apiText = entryField.text else { return }
        UserDefaultManager.setSmartMirrorAPI(API: apiText)
        ipAddressDelegate?.reload()
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: Keyboard Functions
extension PresentIPAddressEntryViewController {
    @objc func handleDismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    func setupKeyboardDismissal() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard)))
    }
    
    @objc func handleDismiss() {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
}

