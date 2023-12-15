//
//  EditNameViewController.swift
//  Navarrete_Alexis_BetaApp
//
//  Created by Alexis Navarrete on 11/2/23.
//

import UIKit
protocol settingEditDel {
    func editSetName(name: String)
}
class EditNameViewController: UIViewController {
    var delegate: settingEditDel?
    @IBOutlet weak var editName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelEdit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // make sure there is a name to replace the old one with, if so send the info back and make the change 
    @IBAction func commitEditButton(_ sender: Any) {
        if editName.text == "" {
            
        } else {
            self.delegate?.editSetName(name: editName.text!)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
