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

    override func viewDidLoad() {
        super.viewDidLoad()
        let txtApiKey = DetailsTextField(label: "API Key", text: module?.key ?? "", placeholder: "API Key")
        stackView.addArrangedSubview(txtApiKey)
        showModuleDetailsForModule()
    }
    
    private func showModuleDetailsForModule() {
        switch module!.name {
            case APINames.DARK_SKY.rawValue:
                 self.title = "Dark Sky"
                 let txtZipcodeKey = DetailsTextField(label: "Zipcode Key", text: module?.zipcodekey ?? "", placeholder: "")
                 let txtZipcode = DetailsTextField(label: "Zipcode", text: module?.zipcode ?? "", placeholder: "")
                 addFieldsToStackView([txtZipcodeKey, txtZipcode])
            case APINames.CLOCK.rawValue:
                 self.title = "Clock"
                 print("Show clock controls")
            case APINames.NEWS_API.rawValue:
                 self.title = "News API"
                 let txtSource = DetailsTextField(label: "Source", text: module?.source ?? "", placeholder: "")
                 let txtSortBy = DetailsTextField(label: "Sort By", text: module?.sortBy ?? "", placeholder: "")
                 addFieldsToStackView([txtSource, txtSortBy])
            case APINames.RANDOM_FAMOUS_QUOTES.rawValue:
                 self.title = "Random Famous Quotes"
                 let txtCategory = DetailsTextField(label: "Category", text: module?.category ?? "", placeholder: "")
                 addFieldsToStackView([txtCategory])
            case APINames.WUNDERLIST.rawValue:
                 self.title = "Wunderlist"
                 let txtClientId = DetailsTextField(label: "Client ID", text: module?.clientid ?? "", placeholder: "")
                 let txtListId = DetailsTextField(label: "List ID", text: module?.listid ?? "", placeholder: "")
                 addFieldsToStackView([txtClientId, txtListId])
            default:
                print("UNKNOWN MODULE")
        }
    }
    
    private func addFieldsToStackView(_ fields: [DetailsTextField]) {
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
