//
//  DeleteSetViewController.swift
//  Navarrete_Alexis_BetaApp
//
//  Created by Alexis Navarrete on 11/2/23.
//

import UIKit
protocol settingDeleteDel {
    func deleteSet()
}
class DeleteSetViewController: UIViewController {
    var delegate: settingDeleteDel?
    var name: String = ""
    @IBOutlet weak var setName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelDelete(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteConfirmButton(_ sender: Any) {
        if setName.text == name {
            self.delegate?.deleteSet()
            self.dismiss(animated: true, completion: nil)
        } else {
            setName.text = "type exactly the same"
        }
    }
    
}
