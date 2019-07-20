//
//  ModuleDetailViewController.swift
//  Smart Mirror
//
//  Created by Hasan Shami on 11/1/17.
//  Copyright © 2017 Hasan Shami. All rights reserved.
//

import UIKit

class ModuleDetailViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var stackView: UIStackView!
    
    var module: Module? = nil
    var saveButton : UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .radicalRed
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        guard let icon = UIImage.keyIcon else { return }
        let txtApiKey = DetailsTextField(label: "API Key", text: module?.key ?? "", placeholder: "API Key", icon: icon)
        stackView.addArrangedSubview(txtApiKey)
        showModuleDetailsForModule()
        setupNavBar()
        setupSaveButton()
        setupKeyboardDismissal()
    }
    
    @objc func handleSave() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupSaveButton() {
        view.addSubview(saveButton)
        saveButton.anchor(topAnchor: nil, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 20, paddingRight: 20, width: 0, height: 30)
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .radicalRed
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    private func showModuleDetailsForModule() {
        switch module!.name {
            case APINames.DARK_SKY.rawValue:
                setupDarkSky()
            case APINames.CLOCK.rawValue:
                 self.navigationItem.title = "Clock"
                 print("Show clock controls")
            case APINames.NEWS_API.rawValue:
                setupNews()
            case APINames.RANDOM_FAMOUS_QUOTES.rawValue:
                setupQuotes()
            case APINames.WUNDERLIST.rawValue:
                setupWunderlist()
            default:
                print("UNKNOWN MODULE")
        }
    }
    
    private func addFieldsToStackView(_ fields: [DetailsTextField]) {
        stackView.spacing = 42
        stackView.distribution = .fillEqually
        for field in fields {
            stackView.addArrangedSubview(field)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: -API UI setup functions
extension ModuleDetailViewController {
    fileprivate func setupDarkSky() {
        self.navigationItem.title = "Dark Sky"
        let txtZipcodeKey = DetailsTextField(label: "Zipcode Key", text: module?.zipcodekey ?? "", placeholder: "", icon: UIImage.zipcodeKeyIcon!)
        let txtZipcode = DetailsTextField(label: "Zipcode", text: module?.zipcode ?? "", placeholder: "",icon: UIImage.zipcodeIcon!)
        addFieldsToStackView([txtZipcodeKey, txtZipcode])
    }
    
    fileprivate func setupNews() {
        self.navigationItem.title = "News API"
        let txtSource = DetailsTextField(label: "Source", text: module?.source ?? "", placeholder: "", icon: UIImage.sourceIcon!)
        let txtSortBy = DetailsTextField(label: "Sort By", text: module?.sortBy ?? "", placeholder: "", icon: UIImage.sortIcon!)
        addFieldsToStackView([txtSource, txtSortBy])
    }
    
    fileprivate func setupQuotes() {
        self.navigationItem.title = "Random Famous Quotes"
        let txtCategory = DetailsTextField(label: "Category", text: module?.category ?? "", placeholder: "", icon: UIImage.sourceIcon!)
        addFieldsToStackView([txtCategory])
    }
    
    fileprivate func setupWunderlist() {
        self.navigationItem.title = "Wunderlist"
        let txtClientId = DetailsTextField(label: "Client ID", text: module?.clientid ?? "", placeholder: "", icon: UIImage.clientIcon!)
        let txtListId = DetailsTextField(label: "List ID", text: module?.listid ?? "", placeholder: "", icon: UIImage.listIcon!)
        addFieldsToStackView([txtClientId, txtListId])
    }
}


// MARK: Keyboard Functions
extension ModuleDetailViewController {
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
